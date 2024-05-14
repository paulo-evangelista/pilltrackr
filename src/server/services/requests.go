package services

import (
	"fmt"
	"log"
	"github.com/gin-gonic/gin"
	"g5/server/db"
	"g5/server/types"
)

func CreateRequest(
	c *gin.Context,
	clients types.Clients,
	userEmail string,
	productCodes []string,
	isUrgent bool,
	description string,
	) {

		var user db.User
		if err := clients.Pg.Where("email = ?", userEmail).First(&user).Error; err != nil {
			c.JSON(400, gin.H{"error": "Usuário não encontrado"})
			return 
		}
	
		// Criar um novo Request para o usuário
		newRequest := db.Request{
			UserId:      user.ID,
			Description: description,
			IsUrgent:    isUrgent,
		}
	
		// Salvar o novo Request no banco de dados
		if err := clients.Pg.Create(&newRequest).Error; err != nil {
			log.Fatalf("Erro ao criar o novo pedido: %v", err)
			c.JSON(500, gin.H{"error": "Erro ao criar o novo pedido"})
		}
	
		fmt.Println("Novo pedido criado com sucesso:", newRequest)
		c.JSON(201, gin.H{"message": "Pedido criado com sucesso"})
}
