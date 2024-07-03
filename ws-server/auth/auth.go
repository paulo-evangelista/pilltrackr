package auth

import (
	"crypto/sha1"
	"fmt"
	"g5/ws-server/db"

	"gorm.io/gorm"
)

func ValidateToken(pg *gorm.DB, token string) (uint, bool, error) {

	if token == "" {
		return 0, false, fmt.Errorf("token não informado")
	}

	hasher := sha1.New()
	hasher.Write([]byte(token))
	internalId := fmt.Sprintf("%x", hasher.Sum(nil))[:6]

	fmt.Println(" \n-> [AuthUserMiddleware] Token de autenticação válido. token: ", token, " user_internal_id: ", internalId)

	return db.ValidateUser(internalId, pg)

}
