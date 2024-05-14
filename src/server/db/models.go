package db

import (
	"gorm.io/gorm"
)

// Usuarios
type User struct {
    gorm.Model
    Email    string `gorm:"unique;not null"`
    Password string `gorm:"not null"`
    Requests []Request
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
	Id         int `gorm:"primaryKey; autoIncrement"`
	SentAt     int `gorm:"autoCreateTime:milli"`
	RequestID  uint
	Content    string
	SentByUser bool // true se a mensagem foi enviada pelo usuário, false se foi enviada pela central
}
