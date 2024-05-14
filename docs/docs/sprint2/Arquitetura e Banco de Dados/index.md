---
title: Arquitetura e Banco de Dados
sidebar_position: 5
---

# Arquitetura

![Arquitetura da Soluçao](/img/arch-v2.png)

## Modelagem do Banco de Dados

![Modelagem Banco de Dados](/img/modelagem-db-m10-v3.png)

## Descrição das Tabelas 

### User

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | INT | Identificador único do usuário |
| `Name` | STRING | Nome do usuário |
| `Email` | STRING | Endereço de e-mail do usuário |
| `Password` | STRING | Senha do usuário |

### ReportType

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | INT | Identificador único do tipo de Report |
| `Report` | STRING | Nome do tipo de Report |

### Reports

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | INT | Identificador único do Report |
| `ReportId` | STRING | Chave estrangeira do tipo de report |
| `UserId` | STRING | Chave estrangeira do usuario solicitante |
| `Description` | STRING | Descrição do report |
| `Timestamp` | STRING | Data e hora da criação do report |

### Item

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | INT | Identificador único item |
| `ItemName` | STRING | Nome do item |

### Requests

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | INT | Identificador único da requisição |
| `ItemId` | STRING | Chabe estrangeira do item solicitado |
| `UserId` | STRING | Chave estrangeira do usuario solicitante |
| `Description` | STRING | Descrição da solicitação |
| `Timestamp` | STRING | Data e hora da criação do report |

### Log

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | INT | Identificador único do Log |
| `EntryId` | STRING | Chave estrangeira da solicitação |
| `Timestamp` | STRING | Data e hora da criação do report |

### Pyxis Region

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | INT | Identificador único do Pyxis |
| `Nome` | STRING | Identificador do Sirio Libanes para o Pyxis |
| `Location` | STRING | Localização do Pyxis |

**Relações:**

**1. Relação User-Report:**

* Um usuário pode gerar diversos relatórios.
* Um relatório é criado por um único usuário.

Essa relação é representada pela chave estrangeira `UserId` na tabela `Reports`, que se refere à coluna `Id` na tabela `User`.

**2. Relação ReportType-Report:**

* Um tipo de relatório pode ser utilizado em diversos relatórios.
* Um relatório está associado a um único tipo de relatório.

Essa relação é representada pela chave estrangeira `ReportId` na tabela `Reports`, que se refere à coluna `Id` na tabela `ReportType`.

**3. Relação Item-Request:**

* Um item pode ser solicitado em diversas requisições.
* Uma requisição solicita um único item.

Essa relação é representada pela chave estrangeira `ItemId` na tabela `Requests`, que se refere à coluna `Id` na tabela `Item`.

**4. Relação User-Request:**

* Um usuário pode realizar diversas requisições.
* Uma requisição é feita por um único usuário.

Essa relação é representada pela chave estrangeira `UserId` na tabela `Requests`, que se refere à coluna `Id` na tabela `User`.

**5. Relação Request-Log:**

* Uma requisição pode gerar diversos logs.
* Um log está associado a uma única requisição.

Essa relação é representada pela chave estrangeira `EntryId` na tabela `Log`, que se refere à coluna `Id` na tabela `Requests`.
