package controllers

import (
	"fmt"
	"g5/server/services"
	"g5/server/types"

	"github.com/gin-gonic/gin"
)

type createRequestBody struct {
	Email        string   `json:"email" binding:"required"`
	ProductCodes []string `json:"productCodes"`
	Urgent       bool     `json:"urgent"`
	Description  string   `json:"description"`
}

func InitRequestRoutes(r *gin.Engine, clients types.Clients) {

	requests := r.Group("/request")
	{

		requests.POST("/create", func(c *gin.Context) {

			fmt.Println(c.Get("user_id"));

			var req createRequestBody

			if err := c.BindJSON(&req); err != nil {
				c.JSON(400, gin.H{"error": err.Error()})
				return
			}

			fmt.Println("Request received:", req)

			services.CreateRequest(
				c,
				clients,
				req.Email,
				req.ProductCodes,
				req.Urgent || false,
				req.Description,
			)

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
