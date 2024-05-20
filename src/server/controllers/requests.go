package controllers

import (
	"fmt"
	mw "g5/server/middlewares"
	"g5/server/services"
	"g5/server/types"

	"github.com/gin-gonic/gin"
)

type createRequestBody struct {
	ProductCodes []string `json:"productCodes"`
	Urgent       bool     `json:"urgent"`
	Description  string   `json:"description"`
}

type findPixiesRequestBody struct {
	ProductCode   string `json:"productCode"`
	CurrentPixies string `json:"currentPixies"`
}

func InitRequestRoutes(r *gin.Engine, clients types.Clients) {

	requests := r.Group("/request")
	{

		requests.POST("/create", func(c *gin.Context) {

			fmt.Println(c.Get("user_id"))

			var req createRequestBody

			if err := c.BindJSON(&req); err != nil {
				c.JSON(400, gin.H{"error": err.Error()})
				return
			}

			fmt.Println("Request received:", req)

			services.CreateRequest(
				c,
				clients,
				req.ProductCodes,
				req.Urgent || false,
				req.Description,
			)

		})

		requests.GET("/get/:id", mw.IsAdmin(), func(c *gin.Context) {
			services.GetRequest(c, clients, c.Param("id"))
		})

		requests.GET("/getAll", mw.IsAdmin(), func(c *gin.Context) {
			services.GetAllRequests(c, clients)
		})

		// Retorna as mensagens do chat de um request
		// Essa rota retorna as mensagens PASSADAS. O envio e recebiemnto de mensagens em tempo real é feito pelo WebSocket
		requests.GET("/:id/messages", func(c *gin.Context) {
			services.GetAllMessages(c, clients, c.Param("id"))
		})
		requests.POST("/findPixies", func(c *gin.Context) {
			var req findPixiesRequestBody

			if err := c.BindJSON(&req); err != nil {
				c.JSON(400, gin.H{"error": err.Error()})
				return
			}

			fmt.Println("Find Pixies request received:", req)

			services.FindNearestPixies(c, clients, req.ProductCode, req.CurrentPixies)
		})
	}
}
