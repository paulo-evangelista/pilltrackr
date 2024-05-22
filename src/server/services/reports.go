package services

import (
	"fmt"
	"g5/server/db"
	"g5/server/types"
	"log"

	"github.com/gin-gonic/gin"
)

func CreateReport(
	c *gin.Context,
	clients types.Clients,
	reportCodes []string,
	description string,
	currentPixies string,
) {
	if len(reportCodes) == 0 || description == "" {
		c.JSON(400, gin.H{"error": "Informações insuficientes para o relatório. Adicione pelo menos uma descrição ou código de problema"})
		return
	}

	var user db.User
	if err := clients.Pg.Where("internal_id = ?", c.GetString("user_internal_id")).First(&user).Error; err != nil {
		c.JSON(500, gin.H{"error": "Usuário não encontrado"})
		return
	}

	var reports []db.Report
	if err := clients.Pg.Where("code IN ?", reportCodes).Find(&reports).Error; err != nil {
		c.JSON(500, gin.H{"error": "Erro ao encontrar problemas relatados", "details": err})
		return
	}

	newRequest := db.Request{
		UserId:        user.ID,
		Description:   description,
		Reports:       reports,
		CurrentPixies: currentPixies,
	}

	if err := clients.Pg.Create(&newRequest).Error; err != nil {
		log.Fatalf("Erro ao criar o novo relatório: %v", err)
		c.JSON(500, gin.H{"error": "Erro ao criar o novo relatório"})
		return
	}

	fmt.Println("Novo relatório criado com sucesso:", newRequest.ID)
	c.JSON(201, gin.H{"message": "Relatório criado com sucesso", "request": newRequest.ID})
}

func GetReport(c *gin.Context, clients types.Clients, id string) {
	var report db.Request
	if err := clients.Pg.Model(&report).Preload("Reports").Where("id = ?", id).First(&report).Error; err != nil {
		c.JSON(404, gin.H{"error": "Relatório não encontrado"})
		return
	}

	c.JSON(200, report)
}

func GetAllReports(c *gin.Context, clients types.Clients) {
	var reports []db.Request
	if err := clients.Pg.Preload("Reports").Where("reports is not null").Find(&reports).Error; err != nil {
		c.JSON(500, gin.H{"error": "Erro ao buscar relatórios"})
		return
	}

	c.JSON(200, reports)
}
