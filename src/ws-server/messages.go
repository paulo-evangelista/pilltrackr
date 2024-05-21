package main

import (
	"fmt"
	"g5/ws-server/db"
	t "g5/ws-server/types"
)

func messageLoop() {
	fmt.Println("entered message loop")

	for {
		select {

		case msg := <-incomingAdminMsgs:
			handleIncomingAdminMsg(msg)

		case msg := <-incomingMsgs:
			handleIncomingMsg(msg)

		}
	}
}

func handleIncomingAdminMsg(msg t.IncomingMessage) {
	fmt.Println("new admin message: ", msg)
	fmt.Println("saving to db")

	savedMsg, err := db.SaveMessage(
		msg.From,
		msg.Request,
		msg.Content,
		false,
		pg,
	)
	if err != nil {
		fmt.Println("error saving message to db: ", err)
		return
	}

	fmt.Println("o request", savedMsg.Request.ID, "pertence ao user", savedMsg.Request.UserId, "e está recebendo uma mensagem de", msg.From)

	for client := range clients {
		
		if client.Id == savedMsg.Request.UserId || client.IsAdmin {

			if client.Id == msg.From {continue}
			
			fmt.Println("sending message to client:", client.Id)
			client.Conn.WriteJSON(t.OutgoingMessage{
				Message: *savedMsg,
			})
		}
	}

}

func handleIncomingMsg(msg t.IncomingMessage) {
	fmt.Println("new message: ", msg)

	fmt.Println("checking if user has access to request")
	if userOwnsRequest, err := db.CheckIfUserOwnsRequest(msg.From, msg.Request, pg); err != nil || !userOwnsRequest {
		fmt.Println("user does not own request, breaking")
		for client := range clients {
			if client.Id == msg.From {	
				if err != nil {
				client.Conn.WriteJSON(t.OutgoingError{Error: "Erro ao processar mensagem"})
				} else {
				client.Conn.WriteJSON(t.OutgoingError{Error: "Você não tem permissão para acessar essa requisição"})
				}
				break
			}
		}
		return
	}

	fmt.Println("saving to db")
	savedMsg, err := db.SaveMessage(
		msg.From,
		msg.Request,
		msg.Content,
		true,
		pg,
	)
	if err != nil {
		fmt.Println("error saving message to db: ", err)
		return
	}

	for client := range clients {
		if client.Id == msg.From || !client.IsAdmin {
			continue
		}
		fmt.Println("sending message to client:", client.Id)
		client.Conn.WriteJSON(t.OutgoingMessage{
			Message: *savedMsg,
		})
	}

}
