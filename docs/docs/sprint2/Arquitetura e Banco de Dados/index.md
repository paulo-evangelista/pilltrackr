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

### Região Pyxis

| Coluna | Tipo | Descrição |
|---|---|---|
| `Id` | INT | Identificador único do Pyxis |
| `Nome` | STRING | Identificador do Sirio Libanes para o Pyxis |
| `Location` | STRING | Localização do Pyxis |

**Relações:**

**1. Relação Usuário-Relatório:**

* Um usuário pode gerar diversos relatórios.
* Um relatório é criado por um único usuário.

Essa relação é representada pela chave estrangeira `UserId` na tabela `Reports`, que se refere à coluna `Id` na tabela `User`.

**2. Relação Tipo de Relatório-Relatório:**

* Um tipo de relatório pode ser utilizado em diversos relatórios.
* Um relatório está associado a um único tipo de relatório.

Essa relação é representada pela chave estrangeira `ReportId` na tabela `Reports`, que se refere à coluna `Id` na tabela `ReportType`.

**3. Relação Item-Requisição:**

* Um item pode ser solicitado em diversas requisições.
* Uma requisição solicita um único item.

Essa relação é representada pela chave estrangeira `ItemId` na tabela `Requests`, que se refere à coluna `Id` na tabela `Item`.

**4. Relação Usuário-Requisição:**

* Um usuário pode realizar diversas requisições.
* Uma requisição é feita por um único usuário.

Essa relação é representada pela chave estrangeira `UserId` na tabela `Requests`, que se refere à coluna `Id` na tabela `User`.

**5. Relação Requisição-Log:**

* Uma requisição pode gerar diversos logs.
* Um log está associado a uma única requisição.

Essa relação é representada pela chave estrangeira `EntryId` na tabela `Log`, que se refere à coluna `Id` na tabela `Requests`.

**6. Relação Usuário-Equipe:**

* Um usuário pode pertencer a uma ou mais equipes.
* Uma equipe pode ter diversos usuários.

**7. Relação Equipe-Região Pyxis:**

* Uma equipe pode ser responsável por uma ou mais regiões Pyxis.
* Uma região Pyxis pode estar sob a responsabilidade de diversas equipes.

**Observações:**

* As colunas `Email` e `Senha` nas tabelas `Usuário` e `Equipe` são usadas para autenticação.
* A coluna `Localização` na tabela `Equipe` pode ser usada para filtrar equipes por região.
* A coluna `Localização` na tabela `Região Pyxis` pode ser usada para armazenar informações adicionais sobre a região, como coordenadas geográficas ou informações de contato.


**Considerações Adicionais:**

* A modelagem de banco de dados não inclui colunas para data de criação/modificação ou status dos registros.
* Informações adicionais sobre usuários, equipes ou regiões Pyxis podem ser armazenadas em outras tabelas ou campos adicionais.



## Descrição das Relações Entre as Tabelas no Banco de Dados

A modelagem de banco de dados na imagem apresenta um conjunto de tabelas interligadas que representam diferentes entidades do sistema. Através das chaves estrangeiras, as relações entre as tabelas são estabelecidas, permitindo a organização e o gerenciamento eficiente dos dados.



**Observações:**

* A coluna `Timestamp` em diversas tabelas armazena a data e hora da criação do registro, permitindo rastrear alterações e implementar funcionalidades de auditoria.
* A coluna `Location` na tabela `Equipe` pode ser usada para filtrar equipes por região.
* A coluna `Location` na tabela `Região Pyxis` pode armazenar informações adicionais sobre a região, como coordenadas geográficas ou informações de contato.


**Considerações Adicionais:**

* A modelagem de banco de dados não inclui colunas para o status dos registros, como ativo, inativo ou em outra situação.
* Informações adicionais sobre usuários, equipes, itens, regiões Pyxis ou logs podem ser armazenadas em outras tabelas ou campos adicionais.
