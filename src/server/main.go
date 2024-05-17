package main

import (
	"github.com/gin-gonic/gin"
	"g5/server/db"
	"g5/server/types"
	"g5/server/middlewares"
	"g5/server/controllers"

)

func main() {

	r := gin.Default()

	clients := types.Clients{
		Redis: db.SetupRedis(),
		Pg: db.SetupPostgres(),
	}

	r.Use(middlewares.AuthUser());
	r.Use(middlewares.AssertUserExistance(clients.Pg));

	controllers.InitRequestRoutes(r, clients)
	controllers.InitClientRoutes(r, clients)
	controllers.InitAdminRoutes(r, clients)

	r.Run(":8080")
}
