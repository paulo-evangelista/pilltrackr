package services

// import (
// 	"fmt"
// 	"g5/server/db"
// 	"g5/server/types"
// 	"log"

// 	"github.com/gin-gonic/gin"
// )

// func CreateReport(
// 	c *gin.Context,
// 	clients types.Clients,
// 	report []int,
// 	description string,
// 	pixiesID uint,
// ) {

// 	if len(report) == 0 && description == "" {
// 		c.JSON(400, gin.H{"error": "Pedido vazio. Adicione pelo menos a descrição ou um produto"})
// 		return
// 	}

// 	var user db.User
// 	if err := clients.Pg.Where("internal_id = ?", c.GetString("user_internal_id")).First(&user).Error; err != nil {
// 		c.JSON(500, gin.H{"error": "Usuário não encontrado (Isso não deveria acontecer)"})
// 		return
// 	}

// 	var reports []db.Report
// 	if err := clients.Pg.Where("id IN ?", report).Find(&reports).Error; err != nil {
// 		c.JSON(400, gin.H{"message": "failed to find reports", "error": err})
// 		return
// 	}

// 	// Criar um novo Report para o usuário
// 	newReport := db.Request{
// 		UserId:      user.ID,
// 		Description: description,
// 		Reports:     reports,
// 		PixiesId:    pixiesID,
// 	}

// 	// Salvar o novo Report no banco de dados
// 	if err := clients.Pg.Create(&newReport).Error; err != nil {
// 		log.Fatalf("Erro ao criar o novo problema: %v", err)
// 		c.JSON(500, gin.H{"error": "Erro ao criar o novo problema"})
// 	}

// 	if err := clients.Pg.Model(&newReport).Association("Reports").Append(reports); err != nil {
// 		log.Fatalf("Erro ao associar problemas: %v", err)
// 		c.JSON(500, gin.H{"error": "Erro ao associar problemas"})
// 		return
// 	}

// 	fmt.Println("Novo problema criado com sucesso:", newReport)
// 	c.JSON(201, gin.H{"message": "Problema criado com sucesso", "report": newReport.ID})
// }

// func GetUserReports(c *gin.Context, clients types.Clients) {
// 	var user db.User
// 	if err := clients.Pg.Where("internal_id = ?", c.GetString("user_internal_id")).First(&user).Error; err != nil {
// 		c.JSON(500, gin.H{"error": "Usuário não encontrado (Isso não deveria acontecer)"})
// 		return
// 	}

// 	var reports []db.Report
// 	if err := clients.Pg.Preload("Reports").Preload("Pixies").Where("user_id = ?", user.ID).Find(&reports).Error; err != nil {
// 		c.JSON(500, gin.H{"error": "Erro ao buscar pedidos do usuário"})
// 		return
// 	}

// 	c.JSON(200, reports)
// }

// func GetReport(c *gin.Context, clients types.Clients, id string) {

// 	var report db.Report
// 	if err := clients.Pg.Preload("Reports").Preload("Pixies").Where("id = ?", id).First(&report).Error; err != nil {
// 		c.JSON(404, gin.H{"error": "Problema não encontrado"})
// 		return
// 	}

// 	c.JSON(200, report)
// }

// func GetAllReports(c *gin.Context, clients types.Clients) {
// 	var reports []db.Report
// 	if err := clients.Pg.Preload("Reports").Preload("Pixies").Find(&reports).Error; err != nil {
// 		c.JSON(500, gin.H{"error": "Erro ao buscar problemas"})
// 		return
// 	}

// 	c.JSON(200, reports)
// }

// func GetAllReportMessages(c *gin.Context, clients types.Clients, id string) {
// 	var messages []db.Message
// 	if err := clients.Pg.Where("report_id = ?", id).Find(&messages).Error; err != nil {
// 		c.JSON(500, gin.H{"error": "Erro ao buscar mensagens"})
// 		return
// 	}

// 	c.JSON(200, messages)
// }
