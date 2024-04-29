package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
)

func setupRouter() *gin.Engine {
	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, "Hello World!")
	})

	r.GET("/:name", func(c *gin.Context) {
		name := c.Params.ByName("name")
		c.String(http.StatusOK,"Hello, %s!", name)
	})

	return r
}

func main() {
	r := setupRouter()
	r.Run(":8080")
}