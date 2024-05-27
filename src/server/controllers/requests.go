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
	PixiesID     uint     `json:"pixiesID"`
}

type findPixiesRequestBody struct {
	ProductCode   string `json:"productCode"`
	CurrentPixies string `json:"currentPixies"`
}

type addAssigneeRequestBody struct {
	RequestID uint `json:"requestID"`
	UserID    uint `json:"userID"`
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
				req.PixiesID,
			)

		})

		requests.GET("/user", func(c *gin.Context) {
			services.GetUserRequests(c, clients)
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
	
		requests.POST("/addAssignee", mw.IsAdmin(), func(c *gin.Context) {
			var req addAssigneeRequestBody

			if err := c.BindJSON(&req); err != nil {
				c.JSON(400, gin.H{"error": err.Error()})
				return
			}

			if err := services.AddAssigneeToRequest(clients, req.RequestID, req.UserID); err != nil {
				c.JSON(400, gin.H{"error": err.Error()})
				return
			}

			c.JSON(200, gin.H{"message": "Assignee added successfully"})
		})
	}
}
