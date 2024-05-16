package types

import (
	"github.com/gorilla/websocket"
)

type Client struct {
	Conn    *websocket.Conn
	Id      int
	IsAdmin bool
}

type IncomingMessage struct {
	From    int    `json:"from"`
	Request int    `json:"request"`
	Content string `json:"content"`
}

type IncomingError struct {
	Error string `json:"error"`
}

type IncomingSuccess struct {
	Message string `json:"message"`
}