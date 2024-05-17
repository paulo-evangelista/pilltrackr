package db

import (
	"fmt"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"log"
	"os"
)

func SetupPostgres() *gorm.DB {

	dbHost := os.Getenv("DB_HOST")
	if dbHost == "" {
		log.Fatal("DB_HOST environment variable is not set.")
		os.Exit(1)
	}

	dsn := fmt.Sprintf("host=%s user=postgres password=admin123 dbname=postgres port=5432 sslmode=disable TimeZone=America/Sao_Paulo", dbHost)

	dbClient, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Could not open database connection")
		os.Exit(1)
	}

	fmt.Println(" -> Inicialização Postgres e Redis concluída")

	return dbClient
}
