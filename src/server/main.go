package main

import (
	"g5/server/controllers"
	"g5/server/db"
	"g5/server/middlewares"
	"g5/server/types"
	"github.com/gin-gonic/gin"
	"github.com/penglongli/gin-metrics/ginmetrics"
)

func main() {

	r := gin.Default()

	m := ginmetrics.GetMonitor()
	
	m.AddMetric(&ginmetrics.Metric{
		Type: 	ginmetrics.Counter,
		Name: "db_requests_operations_total",
		Description: "Total number of db requests operations",
		Labels:      []string{"label1"},
	})

	m.AddMetric(&ginmetrics.Metric{
		Type: 	ginmetrics.Counter,
		Name: "db_users_operations_total",
		Description: "Total number of db user operations",
		Labels:      []string{"label1"},
	})

	m.SetMetricPath("/metrics")
	m.Use(r)

	clients := types.Clients{
		Redis: db.SetupRedis(),
		Pg:    db.SetupPostgres(),
	}


	r.Use(middlewares.AuthUser())
	r.Use(middlewares.AssertUserExistance(clients.Pg))

	// controllers.InitReportRoutes(r, clients)
	controllers.InitRequestRoutes(r, clients)
	controllers.InitClientRoutes(r, clients)
	controllers.InitAdminRoutes(r, clients)

	r.Run(":8080")
}
