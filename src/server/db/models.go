package db

import (
	"gorm.io/gorm"
)

type User struct {
	gorm.Model
	Email    string
	Password string
}

type Request struct {
	gorm.Model
	ItemId      string
	Description string
}

type ItemType struct {
	gorm.Model
	Item string
}
