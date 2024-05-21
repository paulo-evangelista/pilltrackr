package types

import (
	"g5/ws-server/db"
	"github.com/gorilla/websocket"
)

type Client struct {
	Conn    *websocket.Conn
	Id      uint
	IsAdmin bool
}

type IncomingMessage struct {
	From    uint	// Esse campo não vem do cliente, é preenchido no servidor
	Request uint   `json:"request"`
	Content string `json:"content"`
}

type IncomingError struct {
	Error string `json:"error"`
}

type IncomingSuccess struct {
	Message string `json:"message"`
}

type OutgoingMessage struct {
	Message db.Message `json:"message"`
}

type OutgoingError struct {
	Error string `json:"error"`
}