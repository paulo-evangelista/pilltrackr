package controllers

import (
	"g5/server/services"
	"g5/server/types"
	"github.com/gin-gonic/gin"
)

func InitClientRoutes(r *gin.Engine, clients types.Clients) {
	client := r.Group("/client")
	{

		client.GET("/ping", func(c *gin.Context) {
			c.JSON(200, gin.H{"message": "Hello, clients!"})
		})

		client.GET("/getAllProducts", func(c *gin.Context) {
			products, err := services.GetAllProducts(clients)
			if err != nil {
				c.JSON(500, gin.H{"error": err.Error()})
				return
			}
			c.Data(200, "application/json", products)
		})

	}
}
