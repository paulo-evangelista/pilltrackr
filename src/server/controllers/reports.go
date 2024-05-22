package controllers

import (
	"fmt"
	mw "g5/server/middlewares"
	"g5/server/services"
	"g5/server/types"

	"github.com/gin-gonic/gin"
)

type createReportBody struct {
	CurrentPixies string `json:"currentPixies"`
	Report        string `json:"report"`
	Description   string `json:"description"`
}

func InitReportRoutes(r *gin.Engine, clients types.Clients) {

	reports := r.Group("/report")
	{
		reports.POST("/create", func(c *gin.Context) {
			var req createReportBody

			if err := c.BindJSON(&req); err != nil {
				c.JSON(400, gin.H{"error": err.Error()})
				return
			}

			fmt.Println("Report received:", req)

			services.CreateReport(
				c,
				clients,
				req.CurrentPixies,
				req.Report,
				req.Description,
			)
		})

		reports.GET("/get/:id", mw.IsAdmin(), func(c *gin.Context) {
			services.GetReport(c, clients, c.Param("id"))
		})

		reports.GET("/getAll", mw.IsAdmin(), func(c *gin.Context) {
			services.GetAllReports(c, clients)
		})
	}
}
