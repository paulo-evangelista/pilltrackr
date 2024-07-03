package db

import (
	"fmt"
	"gorm.io/gorm"
)

func ValidateUser(internalId string, pg *gorm.DB) (uint, bool, error) {
	var user User
	if tx := pg.Where("internal_id = ?", internalId).First(&user); tx.Error != nil || tx.RowsAffected == 0 {
		return 0, false, fmt.Errorf("usuário não encontrado")
	} 
	if user.ID == 0 {
		return 0, false, fmt.Errorf("houve um problema ao buscar o usuário no banco de dados")
	}
	return user.ID, user.IsAdmin, nil
}

func SaveMessage(userId uint, requestID uint, content string, sentByUser bool, pg *gorm.DB) (*Message, error) {
	message := Message{
		UserID: userId,
		RequestID: requestID,
		Content: content,
		SentByUser: sentByUser,
	}
	tx := pg.Create(&message)
	if tx.Error != nil {
		fmt.Println(tx.Error)
		return nil, tx.Error
	}

	tx = pg.Preload("User").Preload("Request").First(&message, message.ID)
	if tx.Error != nil {
		fmt.Println(tx.Error)
		return nil, tx.Error
	}

	fmt.Println("successfully saved message")

	return &message, nil
}

func CheckIfUserOwnsRequest(userId uint, requestId uint, pg *gorm.DB) (bool, error) {
	var request Request
	tx := pg.Where("user_id = ? AND id = ?", userId, requestId).First(&request)
	if tx.Error != nil {
		return false, tx.Error
	}
	return request.ID != 0, nil
}