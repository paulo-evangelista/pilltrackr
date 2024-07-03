package main

import (
	"fmt"
	"g5/ws-server/db"
	t "g5/ws-server/types"
	"log"
	"net/http"
	"os"
	"gorm.io/gorm"
)

var connectedUserIDs = make(map[uint]bool) // Id de todos os usuários conectados (Para garantir que duas pessoas não se conectem ao mesmo tempo)

var clients = make(map[t.Client]bool) // Conexões dos clientes

var incomingMsgs = make(chan t.IncomingMessage)      // Canal de transmissão de mensagens
var incomingAdminMsgs = make(chan t.IncomingMessage) // Canal de transmissão de mensagens dos admins

var pg *gorm.DB

func main() {

	// Inicializa o banco de dados
	pg = db.SetupPostgres()

	// A função handleConnections é chamada sempre que um novo cliente se conecta.
	// Ela é responsável por validar o token do usuário, manter uma lista de usuários conectados e fazer o parsing das mensagens recebidas.
	// Quando o usuário manda uma mensagem, essa função a coloca no channel de mensagens.
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {handleConnections(pg, w, r)})

	// A função messageLoop fica escutando os channels de mensagens e lida com elas de acordo.
	// Faz a transmissão entre clientes e salva as msgs no banco de dados.
	go messageLoop()
	
	log.Println("Servidor iniciado na porta :8081")
	err := http.ListenAndServe(":8081", nil)

	if err != nil {
		fmt.Println("ListenAndServe: ", err)
		os.Exit(1)
	}

}
