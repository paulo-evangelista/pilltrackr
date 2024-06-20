---
title: Integração Mobile e Backend
sidebar_position: 1
---

Durante a quarta sprint do projeto, o grupo se dedicou a realizar a integração entre as telas da aplicação Mobile, desenvolvida em Flutter, e o back-end da aplicação. Feita a integração, seria possível processar as requisições realizadas pelo usuário, de modo que os usuários da farmácia central fossem capaz de receber as solicitações dos enfermeiros, os quais também deveriam receber feedback acerca de seus pedidos feitos por meio do aplicativo.

**Telas integradas**

As telas foram integradas de modo que fosse permitido interagir através das rotas criadas no back-end da aplicação. O URL base da aplicação, https://pilltrackr.cathena.io/api, permite que diferentes endpoints sejam acessados.

<code>my_requests.dart</code> 

A tela de requisições enviadas pelo usuário foi integrada. Atualmente, ela bate no endpoint <code>/request/user</code>. Isto é, uma vez que o enfermeiro faz a solicitação de um medicamento ou reporta um indidente relacionado ao Pyxis, sua solicitação é processada no back-end, armazenada no banco de dados, e fica disponível na página correspondente ao histórico de solicitações do usuário.

<code>medicine_request.dart</code>

A tela que permite ao usuário a solicitação de um medicamento é considerada uma das mais importantes da aplicação, uma vez que permite a comunicação entre o enfermeiro e a farmácia central de forma ágil. Essa tela também foi integrada ao back-end da solução, de modo que seja levada para a visualização dos usuários que recebem as requisições. O endpoint correspondente é <code>/client/getPreRequestData</code>.
