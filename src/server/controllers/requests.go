package controllers

import (
	"g5/server/types"
	"github.com/gin-gonic/gin"
)

func InitRequestRoutes(r *gin.Engine, clients types.Clients) {

	requests := r.Group("/request")
	{

		requests.POST("/create", func(c *gin.Context) {
			c.JSON(200, "Hello, requests!")
		})

		requests.GET("/:id", func(c *gin.Context) {
			c.JSON(200, "Hello, requests!")
		})

		// Retorna as mensagens do chat de um request
		// Essa rota retorna as mensagens PASSADAS. O envio e recebiemnto de mensagens em tempo real é feito pelo WebSocket
		requests.GET("/getPastMessages", func(c *gin.Context) {
			c.JSON(200, "Hello, requests!")
		})
	}
}
