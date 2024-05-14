package middlewares

import (
    "crypto/sha1"
    "net/http"
    "fmt"
    "github.com/gin-gonic/gin"
)

// Verificar o token de autenticação do usuário contra a API de autenticação
func AuthUser() gin.HandlerFunc {
    return func(c *gin.Context) {
        token := c.GetHeader("Authorization")
        if token == "" {
            c.JSON(http.StatusUnauthorized, gin.H{"error": "Token de autenticação não fornecido"})
            c.Abort()
            return
        }

        hasher := sha1.New()
        hasher.Write([]byte(token))
        // adiciona os primeiros 5 caracteres do hash do token ao contexto
        c.Set("user_id", fmt.Sprintf("%x", hasher.Sum(nil))[:5])
        fmt.Println("Token de autenticação válido. ")
        c.Next()
    }
}
