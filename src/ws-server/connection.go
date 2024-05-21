package main

import (
	"fmt"
	"g5/ws-server/auth"
	t "g5/ws-server/types"
	"net/http"
	u "g5/ws-server/utils"
	"github.com/gorilla/websocket"
	"gorm.io/gorm"
)

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func handleConnections(pg *gorm.DB, w http.ResponseWriter, r *http.Request) {
	u.PrintConnectionStart()

	token := r.URL.Query().Get("token")
	fmt.Println("got token ", token)

	if token == "" {
		fmt.Println("token is empty")
		u.PrintConnectionResult(false)
		http.Error(w, "Token não informado", http.StatusBadRequest)
		return
	}
	
	fmt.Println("validating")
	userId, isAdmin, err := auth.ValidateToken(pg, token)
	if err != nil {
		u.PrintConnectionResult(false)
		http.Error(w, "Erro ao validar token, recusando...", http.StatusBadRequest)
		return
	}
	fmt.Println("userId ", userId, "| isAdmin ", isAdmin, "| err ", err)
	
	if connectedUserIDs[userId] {
		fmt.Println("user already connected")
		u.PrintConnectionResult(false)
		http.Error(w, "Usuário já conectado, recusando...", http.StatusBadRequest)
		return
	}

	
	fmt.Println("upgrading connection")
	ws, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer ws.Close()
	
	newClient := t.Client{
		Conn:    ws,
		Id:      userId,
		IsAdmin: isAdmin,
	}
	fmt.Println("Adding new client. Is admin: ", isAdmin, " | ID: ", userId)
	connectedUserIDs[userId] = true
	clients[newClient] = true
	
	u.PrintConnectionResult(true)
	for {
		var msg t.IncomingMessage
		err := ws.ReadJSON(&msg)
		msg.From = userId
		fmt.Println("msg sent by", userId, ":", msg)
		if err != nil {
			fmt.Println("error reading json, disconnecting client")
			delete(clients, newClient)
			delete(connectedUserIDs, userId)
			break
		}
		
		if msg.Content == "" || msg.Request == 0 || msg.From == 0 {
			fmt.Println("mensagem invalida recebida, enviando erro ao cliente")
			ws.WriteJSON(t.IncomingError{Error: "Mensagem inválida"})
			continue
		}
		if newClient.IsAdmin {
			incomingAdminMsgs <- msg
			} else {
				incomingMsgs <- msg
			}
			ws.WriteJSON(t.IncomingSuccess{Message: "Mensagem enviada com sucesso"})
	}
}
