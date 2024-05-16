package services

import (
	"fmt"
	"g5/server/db"
	"g5/server/types"
	"log"

	"github.com/gin-gonic/gin"
)

func CreateRequest(
	c *gin.Context,
	clients types.Clients,
	productCodes []string,

	isUrgent bool,
	description string,
) {

	if len(productCodes) == 0 && description == "" {
		c.JSON(400, gin.H{"error": "Pedido vazio. Adicione pelo menos a descrição ou um produto"})
		return
	}

	var user db.User
	if err := clients.Pg.Where("internal_id = ?", c.GetString("user_internal_id")).First(&user).Error; err != nil {
		c.JSON(500, gin.H{"error": "Usuário não encontrado (Isso não deveria acontecer)"})
		return
	}

	var products []db.Product
	if err := clients.Pg.Where("code IN ?", productCodes).Find(&products).Error; err != nil {
		c.JSON(400, gin.H{"message": "failed to find products", "error": err})
		return
	}

	if len(products) != len(productCodes) {
		c.JSON(500, gin.H{"message": "failed to find products"})
		return
	}

	// Criar um novo Request para o usuário
	newRequest := db.Request{
		UserId:      user.ID,
		Description: description,
		IsUrgent:    isUrgent,
		Products:    products,
	}

	// Salvar o novo Request no banco de dados
	if err := clients.Pg.Create(&newRequest).Error; err != nil {
		log.Fatalf("Erro ao criar o novo pedido: %v", err)
		c.JSON(500, gin.H{"error": "Erro ao criar o novo pedido"})
	}

	fmt.Println("Novo pedido criado com sucesso:", newRequest)
	c.JSON(201, gin.H{"message": "Pedido criado com sucesso", "request": newRequest.ID})
}

func GetRequest(c *gin.Context, clients types.Clients, id string) {

	var request db.Request
	if err := clients.Pg.Model(request).Preload("Products").Where("id = ?", id).First(&request).Error; err != nil {
		c.JSON(404, gin.H{"error": "Pedido não encontrado"})
		return
	}

	c.JSON(200, request)
}

func GetAllRequests(c *gin.Context, clients types.Clients) {
	var requests []db.Request
	if err := clients.Pg.Preload("Products").Find(&requests).Error; err != nil {
		c.JSON(500, gin.H{"error": "Erro ao buscar pedidos"})
		return
	}

	c.JSON(200, requests)
}

func GetAllMessages(c *gin.Context, clients types.Clients, id string) {
	var messages []db.Message
	if err := clients.Pg.Where("request_id = ?", id).Find(&messages).Error; err != nil {
		c.JSON(500, gin.H{"error": "Erro ao buscar mensagens"})
		return
	}

	c.JSON(200, messages)
}
