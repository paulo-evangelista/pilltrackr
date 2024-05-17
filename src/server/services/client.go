package services

import (
	"context"
	"fmt"
	"time"
	"g5/server/db"
	"g5/server/types"
	"encoding/json"
)

type UserUpdateParams struct {
	Name  *string `json:"name"`
	Email *string `json:"email"`
	Position *string `json:"position"`
}



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

func UpdateUser(clients types.Clients, userInternalId string, params UserUpdateParams ) error {

	updateData := make(map[string]interface{})

	if params.Name != nil {
		updateData["name"] = *params.Name
	}

	if params.Email != nil {
		updateData["email"] = *params.Email
	}

	if params.Position != nil {
		updateData["position"] = *params.Position
	}

	return clients.Pg.Model(&db.User{}).Where("internal_id = ?", userInternalId).Updates(updateData).Error
}