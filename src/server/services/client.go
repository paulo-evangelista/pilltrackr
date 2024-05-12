package services

import (
	"context"
	"fmt"
	"time"
	"g5/server/db"
	"g5/server/types"
	"encoding/json"
)

func GetAllProducts(clients types.Clients) ([]byte, error) {

	redisRes, err := clients.Redis.Get(context.Background(), "products").Result()

	if err != nil {
		fmt.Printf("Error getting products from Redis (error: %v), fetching from database\n", err.Error())

		var products []db.Product

		tx := clients.Pg.Find(&products)

		if tx.Error != nil {
			return []byte(""), tx.Error
		}

        // Serializar o resultado em JSON
        jsonProducts, err := json.Marshal(products)
        if err != nil {
            return []byte(""), err
        }

		clients.Redis.Set(context.Background(), "products", jsonProducts, time.Hour)
        return jsonProducts, nil
		
	}
	
	return []byte(redisRes), nil
}
