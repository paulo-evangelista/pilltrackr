---
title: Implementação Inicial do Backend
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

### Sistema de Cache com Redis

Para melhorar a performance do backend, foi adicionado o Redis como sistema de cache. O Redis é um banco de dados em memória que permite armazenar e recuperar dados rapidamente, o que é especialmente útil para reduzir a carga de consultas frequentes ao banco de dados PostgreSQL.

### Testes de Carga

Os testes de carga foram configurados utilizando o Locust, uma ferramenta de teste de carga de código aberto. Atualmente, os testes são concentrados em duas principais funcionalidades: criação de usuários através da rota /users e operações relacionadas a pedidos, manipuladas pelos scripts em locustRequest. Este último script é nosso foco principal, tratando tanto do salvamento de pedidos no banco de dados quanto da recuperação desses registros.

#### Executando os Testes de Carga

Para realizar os testes de carga, siga os passos abaixo:

- Navegue até a pasta tests/locust localizada na raiz do projeto.
- Execute os comandos apropriados informados no arquivo "instructions.txt" para iniciar os testes com o Locust.

Isso abrirá a interface do Locust, permitindo que você inicie os testes e monitore os resultados em tempo real através da interface web.

#### Documentação dos Resultados

Os resultados dos testes de carga serão documentados em detalhes em um relatório em formato PDF. Este documento incluirá métricas importantes como o número total de requisições por segundo, tempo de resposta e o número de usuários simulados. Esse relatório proporciona uma visão abrangente do desempenho da aplicação sob diferentes condições de carga, permitindo uma análise precisa da escalabilidade e robustez do sistema.

Certifique-se de consultar o relatório em PDF para ter uma visão detalhada dos resultados do teste de carga.

[Download do Relatório de Teste de Carga](/LocustRequest.pdf)

## Conclusão 

Esta documentação inicial reflete o estado atual do backend, incluindo a configuração do ambiente, funcionalidades implementadas e os primeiros passos na execução de testes de carga. Futuras atualizações focarão em expandir a robustez e eficiência do sistema conforme detalhado nos planos de desenvolvimento.
