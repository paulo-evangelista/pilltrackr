package middlewares

import (
    "net/http"
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

        client := &http.Client{}
		// TODO: Substituir pela URL da API de autenticação
        req, err := http.NewRequest("GET", "TODO_URL_DA_API", nil)
        if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Erro ao criar a requisição para autenticação"})
            return
        }
		
        req.Header.Set("Authorization", token)
        resp, err := client.Do(req)
        if err != nil {
			// Fingindo que o token é válido
			// TODO: desmockar
			// c.JSON(http.StatusInternalServerError, gin.H{"error": "Erro ao chamar a API de autenticação"})
            // c.Abort()
			c.Next()
            return
        }
        defer resp.Body.Close()

        if resp.StatusCode != http.StatusOK {
            c.JSON(http.StatusUnauthorized, gin.H{"error": "Token de autenticação inválido"})
            c.Abort()
            return
        }

        c.Next()
    }
}
