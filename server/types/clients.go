package types

import (
	"gorm.io/gorm"
	"github.com/redis/go-redis/v9"
)

type Clients struct {
	Redis *redis.Client
	Pg *gorm.DB
}
