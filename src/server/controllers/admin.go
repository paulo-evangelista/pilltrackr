package controllers

import (
	"g5/server/types"
	"g5/server/services"
	"github.com/gin-gonic/gin"
)

type createProductBody struct {
	Name string `json:"name"`
	Code string `json:"code"`
}

func InitAdminRoutes(r *gin.Engine, clients types.Clients) {

	r.GET("/admin/ping", func(c *gin.Context) {
		c.JSON(200, "Hello, Admin!")
	})

	r.POST("/admin/createProduct", func(c *gin.Context) {
		var req createProductBody
		if err := c.BindJSON(&req); err != nil {
			c.JSON(400, gin.H{"error": err.Error()})
			return
		}

		res, err := services.CreateProduct(clients, req.Name, req.Code)

		if err != nil {
			c.JSON(500, gin.H{"error": err.Error()})
			return
		}

		c.JSON(200, gin.H{"message":res})

	})
}
