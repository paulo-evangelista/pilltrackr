package controllers

// import (
// 	"fmt"
// 	mw "g5/server/middlewares"
// 	"g5/server/services"
// 	"g5/server/types"

// 	"github.com/gin-gonic/gin"
// )

// type createReportBody struct {
// 	Report      []int  `json:"report"`
// 	Description string `json:"description"`
// 	PixiesID    uint   `json:"pixiesID"`
// }

// func InitReportRoutes(r *gin.Engine, clients types.Clients) {

// 	reports := r.Group("/report")
// 	{

// 		reports.POST("/create", func(c *gin.Context) {

// 			fmt.Println(c.Get("user_id"))

// 			var req createReportBody

// 			if err := c.BindJSON(&req); err != nil {
// 				c.JSON(400, gin.H{"error": err.Error()})
// 				return
// 			}

// 			fmt.Println("Report received:", req)

// 			services.CreateReport(
// 				c,
// 				clients,
// 				req.Report,
// 				req.Description,
// 				req.PixiesID,
// 			)

// 		})

// 		reports.GET("/user", func(c *gin.Context) {
// 			services.GetUserReports(c, clients)
// 		})

// 		reports.GET("/get/:id", mw.IsAdmin(), func(c *gin.Context) {
// 			services.GetReport(c, clients, c.Param("id"))
// 		})

// 		reports.GET("/getAll", mw.IsAdmin(), func(c *gin.Context) {
// 			services.GetAllReports(c, clients)
// 		})

// 		// Retorna as mensagens do chat de um report
// 		// Essa rota retorna as mensagens PASSADAS. O envio e recebiemnto de mensagens em tempo real é feito pelo WebSocket
// 		reports.GET("/:id/messages", func(c *gin.Context) {
// 			services.GetAllReportMessages(c, clients, c.Param("id"))
// 		})
// 	}
// }
