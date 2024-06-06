---
title: Aplicação de Testes
sidebar_position: 1
---

## Visão Geral dos Testes de Carga

Os testes de carga foram realizados para avaliar a capacidade do sistema em suportar um volume elevado de requisições simultâneas, desde a evolução do nosso backend. Três métricas principais foram monitoradas durante os testes:

Total de Requisições por Segundo: A taxa de requisições que o sistema consegue processar por segundo.

Tempo de Resposta: O tempo necessário para o sistema responder a uma requisição.

Número de Usuários Simultâneos: A quantidade de usuários que o sistema consegue suportar simultaneamente antes de ocorrerem falhas.

[Clique aqui para visualizar o novo teste de carga](/img/carga.png)

### Descoberta de Limitação de Capacidade

Durante os testes, observou-se que ao atingir cerca de 400 usuários simultâneos, o banco de dados não conseguiu lidar com a carga adicional, resultando em um erro fatal: sorry, too many clients already. Isso levou ao fracasso de todas as requisições subsequentes, indicando uma limitação na configuração atual do banco de dados em relação ao número de conexões simultâneas que pode suportar.

### Medidas e Observações Futuras

Estamos trabalhando para melhorar a capacidade do banco de dados de manejar um maior número de conexões simultâneas. Embora tenhamos encontrado esta limitação, acreditamos que a capacidade atual seja suficiente para suportar a quantidade de pedidos simultâneos esperada em condições normais de uso. Serão considerados ajustes nas configurações do servidor e do banco de dados, além de possíveis otimizações no código, para aumentar a robustez e escalabilidade do sistema.