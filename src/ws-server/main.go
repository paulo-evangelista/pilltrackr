package main

import (
	"fmt"
	t "g5/ws-server/types"
	"github.com/gorilla/websocket"
	"log"
	"net/http"
)

var connectedUserIDs = make(map[int]bool) // Id de todos os usuários conectados (Para garantir que duas pessoas não se conectem ao mesmo tempo)

var clients = make(map[t.Client]bool) // Conexões dos clientes

var incomingMsgs = make(chan t.IncomingMessage)      // Canal de transmissão de mensagens
var incomingAdminMsgs = make(chan t.IncomingMessage) // Canal de transmissão de mensagens dos admins

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func main() {
	http.HandleFunc("/", handleConnections)
	log.Println("Servidor iniciado na porta :8081")
	go messageLoop()
	err := http.ListenAndServe(":8081", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}

}

func handleConnections(w http.ResponseWriter, r *http.Request) {

	token := r.URL.Query().Get("token")
	fmt.Println("got token ", token)

	if token == "" {
		fmt.Println("token is empty")
		http.Error(w, "Token não informado", http.StatusBadRequest)
		return
	}

	fmt.Println("validating")
	userId, isAdmin, err := validateToken(token)
	fmt.Println("userId ", userId, "| isAdmin ", isAdmin, "| err ", err)
	if err != nil {
		http.Error(w, "Erro ao validar token", http.StatusBadRequest)
		return
	}

	if connectedUserIDs[userId] {
		fmt.Println("user already connected")
		http.Error(w, "Usuário já conectado", http.StatusBadRequest)
		return
	}

	fmt.Println("upgrading connection")
	ws, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Fatal(err)
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

	for {
		var msg t.IncomingMessage
		err := ws.ReadJSON(&msg)
		fmt.Println("msg sent by", newClient.Id, ":", msg)
		if err != nil {
			fmt.Println("error reading json, disconnecting client")
			log.Printf("error: %v", err)
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

func validateToken(token string) (int, bool, error) {
	// Valida o token e retorna o ID do usuário e se ele é admin
	if token == "admin" {
		return 0, true, nil
	}
	return 1, false, nil
}

func messageLoop() {
	fmt.Println("entered message loop")

	for {
		select {

		case msg := <-incomingAdminMsgs:
			fmt.Println("new message in incomingAdminMsgs channel: ", msg)

		case msg := <-incomingMsgs:
			fmt.Println("new message in incomingMsgs channel: ", msg)

		}
	}
}
