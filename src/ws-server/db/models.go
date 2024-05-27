package db

import (
	"gorm.io/gorm"
)

// Usuarios
// InternalId é o id do usuário no sistema de autenticação do sirio
// Esse ID já passou pelo middleware de autenticação, então podemos confiar nele
// Portanto, gostaria de lembrar que não precisamos salvar a senha do usuário no banco de dados
type User struct {
	gorm.Model
	InternalId string `gorm:"unique;not null"`
	Position   string
	Name       string
	Email      string
	Requests   []Request
	Messages   []Message
	IsAdmin    bool `gorm:"default:false"` // true se o usuário é da central, false se é um usuário comum
}

// Pedidos
type Request struct {
	gorm.Model
	UserId      uint
	Products    []Product `gorm:"many2many:request_products;"`
	Description string
	Messages    []Message
	Closed      bool `gorm:"default:false"`
	IsUrgent    bool `gorm:"default:false"`
}

// Produto (Equipamentos, insumos, remédios, etc.)
type Product struct {
	gorm.Model
	Name string `gorm:"not null"`
	Code string `gorm:"unique;not null"` // Código do item (código de barras?)
}

// Mensagem
type Message struct {
	gorm.Model
	RequestID  uint
	Request	Request
	Content    string
	SentByUser bool // true se a mensagem foi enviada pelo usuário, false se foi enviada pela central
	UserID     uint
	User       User
}

