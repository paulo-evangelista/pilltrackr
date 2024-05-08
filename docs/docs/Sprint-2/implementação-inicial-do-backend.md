---
sidebar_position: 3
---

# Documentação da Implementação Inicial do Backend

## Visão Geral 

Este documento descreve a implementação inicial do backend do projeto, conforme realizado até o momento, incluindo os detalhes da configuração local, uso de containerização e os testes de carga iniciais. A implementação utiliza a linguagem Go com o framework Gin para o servidor HTTP e interage com um banco de dados PostgreSQL.

## Estrutura do Projeto

O backend do projeto está localizado na pasta `server` dentro de `src`, contendo os seguintes arquivos principais:

- `main.go`: Arquivo principal do servidor, implementando a lógica HTTP.
- `go.mod` e `go.sum`: Arquivos de gerenciamento de dependências do Go.
- `Dockerfile`: Definição para a construção do container do servidor.

## Setup de Desenvolvimento

### Requisitos

- Docker e Docker Compose: Para rodar o servidor e o banco de dados em containers.
- Go: Para desenvolvimento local e testes do backend.

### Inicialização Local

Para iniciar o backend localmente, utilize o Docker Compose:

```bash 
docker-compose up
```

Isso inicializará o servidor e o banco de dados PostgreSQL, configurados para comunicação interna dentro do Docker.

## Funcionalidades do Backend

### Adição de Usuários

O servidor oferece uma rota POST `/users` que permite adicionar um usuário novo ao banco de dados. O usuário deve fornecer `email` e `senha`, que são então salvos no PostgreSQL.

### Banco de Dados

O banco de dados PostgreSQL é utilizado para persistir os dados dos usuários. Está configurado para iniciar juntamente com o servidor através do Docker Compose, garantindo a persistência necessária.

### Testes de Carga

Os testes de carga foram configurados utilizando o Locust, uma ferramenta de teste de carga de código aberto. Os testes focam na criação de usuários através da rota `/users` para avaliar o desempenho sob carga.

#### Executando os Testes de Carga

Para executar os testes de carga, navegue até a pasta locust que está dentro de tests na raiz do projeto e execute:

```bash
    locust -f locustfile.py
```

Isso iniciará a interface do Locust, onde você pode iniciar os testes e visualizar os resultados em tempo real.

## Conclusão 

Esta documentação inicial reflete o estado atual do backend, incluindo a configuração do ambiente, funcionalidades implementadas e os primeiros passos na execução de testes de carga. Futuras atualizações focarão em expandir a robustez e eficiência do sistema conforme detalhado nos planos de desenvolvimento.
