package main

import (
	"database/sql"
	"encoding/json"

	"context"
	"fmt"
	"log"
	"net/http"
	"time"

	"os"

	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis/v8"
	"github.com/google/uuid"
	_ "github.com/lib/pq"
	"golang.org/x/crypto/bcrypt"
)

type User struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type ItemType struct {
	Id        	string    `json:"id"`
	Item      	string    `json:"item"`
}
// mudar tipos dos ids para int?
type Request struct {
	Id          string    `json:"id"`
	ItemId      string    `json:"itemId"`
	Description string    `json:"description"`
	Timestamp   time.Time `json:"timestamp"`
}

type ReportType struct {
	Id          string    `json:"id"`
	Report      string    `json:"report"`
}

type Report struct {
	Id          string    `json:"id"`
	ReportId    string    `json:"reportId"`
	Description string    `json:"description"`
	Timestamp   time.Time `json:"timestamp"`
}

type Log struct {
	Id          string    `json:"id"`
	EntryId     string    `json:"entryId"`
	Description string    `json:"description"`
	Timestamp   time.Time `json:"timestamp"`
}

var rdb *redis.Client
var db *sql.DB

func createTable() error {
	const query = `
	CREATE TABLE IF NOT EXISTS users (
		id SERIAL PRIMARY KEY,
		email VARCHAR(255) NOT NULL,
		password VARCHAR(255) NOT NULL
	);`
	_, err := db.Exec(query)
	if err != nil {
		return fmt.Errorf("failed to create users table: %v", err)
	}
	// queryTypeRequests (?)
	const typeRequests = `
	CREATE TABLE IF NOT EXISTS itemType (
		id UUID PRIMARY KEY,
		item VARCHAR(255) NOT NULL,
	);`
	_, err = db.Exec(queryRequests)
	if err != nil {
		return fmt.Errorf("failed to create requests table: %v", err)
	}
	// requests ou request (mudar nome da struct)
	const queryRequests = `
	CREATE TABLE IF NOT EXISTS requests (
		id UUID PRIMARY KEY,
		ItemId VARCHAR(255) NOT NULL,
		description TEXT NOT NULL,
		timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
	);`
	_, err = db.Exec(queryRequests)
	if err != nil {
		return fmt.Errorf("failed to create requests table: %v", err)
	}

	const typeReports = `
	CREATE TABLE IF NOT EXISTS reportType (
		id UUID PRIMARY KEY,
		report VARCHAR(255) NOT NULL,
	);`
	_, err = db.Exec(queryRequests)
	if err != nil {
		return fmt.Errorf("failed to create requests table: %v", err)
	}
	// requests ou request (mudar nome da struct)
	const queryReports = `
	CREATE TABLE IF NOT EXISTS reports (
		id UUID PRIMARY KEY,
		reportId VARCHAR(255) NOT NULL,
		description TEXT NOT NULL,
		timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
	);`
	_, err = db.Exec(queryRequests)
	if err != nil {
		return fmt.Errorf("failed to create requests table: %v", err)
	}

	const queryLogs = `
	CREATE TABLE IF NOT EXISTS log (
		id UUID PRIMARY KEY,
		entryId VARCHAR(255) NOT NULL,
		timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
	);`
	_, err = db.Exec(queryRequests)
	if err != nil {
		return fmt.Errorf("failed to create requests table: %v", err)
	}

	log.Println("Tables created or verified successfully")
	return nil
}

func initDB() {
	host := os.Getenv("DB_HOST")
	if host == "" {
		log.Fatal("DB_HOST environment variable is not set.")
	}

	connStr := fmt.Sprintf("host=%s port=5432 user=postgres password=admin123 dbname=postgres sslmode=disable", host)
	var err error

	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Failed to open database: %v", err)
	}

	for i := 0; i < 5; i++ { // Reduce the number of retries
		if err = db.Ping(); err == nil {
			if err = createTable(); err != nil {
				log.Fatal(err)
			}
			log.Println("Connected to the database successfully")
			return
		}
		log.Printf("Failed to connect to database: %v (retrying)", err)
		time.Sleep(5 * time.Second)
	}
	log.Fatal("[FATAL] Cannot connect to DB after retries, exiting")
}

func initRedis() {
	redisHost := os.Getenv("REDIS_HOST")
	if redisHost == "" {
		log.Fatal("REDIS_HOST environment variable is not set.")
		os.Exit(1)
	}

	rdb = redis.NewClient(&redis.Options{
		Addr: fmt.Sprintf("%s:6379", redisHost),
		DB:   0,
	})

	if _, err := rdb.Ping(context.Background()).Result(); err != nil {
		log.Fatalf("Failed to connect to Redis: %v", err)
	}
}

func setupRouter() *gin.Engine {
	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, "Hello World!")
	})

	r.GET("/:name", func(c *gin.Context) {
		name := c.Params.ByName("name")
		c.String(http.StatusOK, "Hello, %s!", name)
	})

	r.POST("/users", func(c *gin.Context) {
		var newUser User
		if err := c.BindJSON(&newUser); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid data"})
			return
		}

		hashedPassword, err := bcrypt.GenerateFromPassword([]byte(newUser.Password), bcrypt.DefaultCost)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not hash password"})
			return
		}

		_, err = db.Exec("INSERT INTO users (email, password) VALUES ($1, $2)", newUser.Email, string(hashedPassword))
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not save user"})
			return
		}

		c.JSON(http.StatusCreated, gin.H{"status": "User created"})
	})

	r.POST("/requests", func(c *gin.Context) {
		var newRequest Request
		if err := c.BindJSON(&newRequest); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid data"})
			return
		}

		newRequest.ID = uuid.New().String()
		newRequest.Timestamp = time.Now()

		_, err := db.Exec("INSERT INTO requests (id, name, description,timestamp) VALUES ($1, $2, $3, $4)", newRequest.ID, newRequest.Name, newRequest.Description, newRequest.Timestamp)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not save request"})
			return
		}

		c.JSON(http.StatusCreated, newRequest)
	})

	r.GET("/requests", func(c *gin.Context) {
		ctx := c.Request.Context()
		val, err := rdb.Get(ctx, "requests").Result()

		if err == redis.Nil {
			// Cache miss; fetch from database
			rows, err := db.Query("SELECT id, name, description, timestamp FROM requests")
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not query requests"})
				return
			}
			defer rows.Close()
			var requests []Request
			for rows.Next() {
				var request Request
				if err := rows.Scan(&request.ID, &request.Name, &request.Description, &request.Timestamp); err != nil {
					c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not parse requests"})
					return
				}
				requests = append(requests, request)
			}
			// Cache the result
			serialized, err := json.Marshal(requests)
			if err == nil {
				rdb.Set(ctx, "requests", serialized, time.Minute*10) // Cache for 10 minutes
			}
			c.JSON(http.StatusOK, requests)
		} else if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Cache fetch error"})
		} else {
			var requests []Request
			if err := json.Unmarshal([]byte(val), &requests); err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to parse cached data"})
				return
			}
			c.JSON(http.StatusOK, requests)
		}
	})

	return r
}

func main() {
	initDB()
	initRedis()
	r := setupRouter()
	r.Run(":8080")
}
