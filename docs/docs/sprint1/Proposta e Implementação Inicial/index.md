---
title: Proposta e Implementação Inicial do Sistema
sidebar_position: 2
---

# Proposta e implementação inicial do sistema

## Requisitos Funcionais e Não Funcionais 

No desenvolvimento de software, a definição clara dos requisitos é crucial para o sucesso do projeto. Estes requisitos são geralmente divididos em duas categorias principais: requisitos funcionais e não funcionais. Compreender a diferença entre esses dois tipos de requisitos é essencial para planejar, projetar e implementar soluções eficazes que atendam às necessidades dos usuários e às expectativas dos stakeholders.


### Autenticação de Usuários
#### Funcional
O sistema deve permitir que os usuários façam login utilizando credenciais válidas.

#### Não Funcional
Deve garantir a segurança das credenciais, utilizando algoritmos de criptografia para proteger as informações de acesso.

### Solicitação de Medicamentos
#### Funcional
Os colaboradores devem poder solicitar medicamentos através da plataforma móvel. Os pedidos devem ser registrados e encaminhados ao sistema backend para processamento.

#### Não Funcional
O tempo médio para processamento de pedidos de medicamentos não deve exceder 5 segundos, garantindo uma experiência responsiva para os usuários.

### Controle de Acesso
#### Funcional
O sistema deve permitir que os administradores modifiquem as permissões de acesso e solicitação de medicamentos para diferentes usuários.

#### Não Funcional
O sistema deve ser capaz de lidar com X usuários simultaneamente sem comprometer a disponibilidade.

### Rastreabilidade de Medicamentos
#### Funcional
Todas as transações relacionadas aos medicamentos, incluindo solicitações e entregas, devem ser rastreadas e registradas no sistema.

#### Não Funcional
A funcionalidade de rastreamento de medicamentos deve estar disponível a todo momento, sem interrupções.

### Integração com Outros Sistemas
#### Funcional
O sistema deve fornecer uma API para integração com sistemas existentes no hospital, como o sistema Tasy e o sistema interno do Pyxis.

#### Não Funcional
A API deve ser compatível com RESTful e suportar o formato JSON, garantindo interoperabilidade e facilidade de integração.

### Monitoramento de Saúde da Aplicação
#### Funcional
O sistema deve incluir funcionalidades para monitorar a saúde da aplicação e alertar os administradores sobre problemas de desempenho ou disponibilidade.

#### Não Funcional
Todas as métricas de monitoramento de saúde da aplicação devem ser documentadas e atualizadas assim que lançada nova atualização, assegurando a continuidade e eficiência operacional.

## Primeira versão da Arquitetura do Sistema
![arch](/img/arch.png)