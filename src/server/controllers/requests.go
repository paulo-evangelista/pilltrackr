package controllers

import (
	"g5/server/types"
	"github.com/gin-gonic/gin"
)

func InitRequestRoutes(r *gin.Engine, clients types.Clients) {

	r.POST("/request/create", func(c *gin.Context) {
		c.JSON(200, "Hello, requests!")
	})

	r.GET("/request/:id", func(c *gin.Context) {
		c.JSON(200, "Hello, requests!")
	})
	
	// Retorna as mensagens do chat de um request
	// Essa rota retorna as mensagens PASSADAS. O envio e recebiemnto de mensagens em tempo real é feito pelo WebSocket
	r.GET("/request/getPastMessages", func(c *gin.Context) {
		c.JSON(200, "Hello, requests!")
	})
}
