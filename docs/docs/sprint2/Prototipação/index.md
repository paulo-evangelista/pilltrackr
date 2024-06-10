---
title: Prototipação
sidebar_position: 4
---
# Protótipo e Experiência do Usuário (UX)

## Visão Geral
Este documento fornece uma visão detalhada do protótipo de um aplicativo destinado a enfermeiros e funcionários da farmácia central, para a requisição de medicamentos e a resolução de problemas recorrentes no Pyxis. O design enfatiza simplicidade, eficiência e clareza para garantir que as necessidades dos enfermeiros sejam atendidas de forma rápida e precisa e o gerenciamento da farmácia seja mais eficiente.

## Estrutura das Telas do Protótipo

### Tela 1: Motivo da Requisição
![img](/img/Tela1.png)
- **Descrição:** O usuário seleciona o motivo da requisição entre "Medicamentos" e "Outros".
- **Componentes:**
  - Texto de boas-vindas: "Olá, Enfermeiro. Qual o motivo da sua requisição?"
  - Botões de seleção: "Medicamentos" e "Outros".
  - Botão "Entrar".

### Tela 2: Requisição de Medicamentos
![img](/img/Tela2.png)
- **Descrição:** Permite ao usuário adicionar medicamentos à lista de requisições.
- **Componentes:**
  - Campo de seleção: "Medicamento Faltante".
  - Botão: "Adicionar medicamento".
  - Alternância: "Precisa imediatamente?".
  - Campo de texto: "Descrição Adicional".
  - Botão "Enviar".

### Tela 3: Requisição de Outros Problemas
![img](/img/Tela3.png)
- **Descrição:** Permite ao usuário relatar problemas recorrentes.
- **Componentes:**
  - Campo de seleção: "Problema Recorrente".
  - Campo de texto: "Descrição Adicional".
  - Botão "Enviar".

### Tela 4: Confirmação de Requisição
![img](/img/Tela4.png)
- **Descrição:** Confirmação de que a requisição foi feita com sucesso, incluindo detalhes sobre o ponto de retirada dos medicamentos.
- **Componentes:**
  - Mensagem de confirmação com código da requisição.
  - Detalhes sobre o local mais próximo com os medicamentos: "Pyxis mais próximo com os medicamentos: MS1347 - 14º Andar".

### Tela 5: Requisições Feitas
![img](/img/Tela5.png)
- **Descrição:** Exibe uma lista de requisições feitas.
- **Componentes:**
  - Lista de requisições com identificador e nome do medicamento.

### Tela 6: Lista de Requisições
![img](/img/Tela6.png)
- **Descrição:** Exibe as requisições pendentes e enviadas.
- **Componentes:**
  - Abas de navegação: "Pendentes" e "Enviadas".
  - Lista de requisições com identificador e nome do medicamento.
  - Botão "Enviar".

### Tela 7: Detalhes da Requisição
![img](/img/Tela7.png)
- **Descrição:** Exibe detalhes adicionais de uma requisição selecionada.
- **Componentes:**
  - Janela modal com a descrição da mensagem da requisição.

### Tela 8: Requisições Enviadas
![img](/img/Tela8.png)
- **Descrição:** Exibe as requisições pendentes e enviadas após a exibição dos detalhes adicionais da requisição.
- **Componentes:**
  - Abas de navegação: "Pendentes" e "Enviadas".
  - Lista de requisições com identificador e nome do medicamento.
  - Botão "Enviar".

### Tela 9: Requisições Pendentes
![img](/img/Tela9.png)
- **Descrição:** Exibe uma lista de requisições pendentes feitas pelo auxiliar.
- **Componentes:**
  - Lista de requisições com identificador e nome do medicamento.
  - Botão "Enviar".

### Tela 10: Chat para Requisições
![img](/img/Tela10.png)
- **Descrição:** Interface de chat para comunicação sobre uma requisição.
- **Componentes:**
  - Interface de mensagens de chat com ícones de usuário e status de envio.

## Experiência do Usuário (UX)

### Navegação
- **Simples e Intuitiva:** A navegação é projetada para ser linear e intuitiva, com telas claramente definidas e opções diretas, permitindo ao usuário completar suas tarefas com o mínimo de esforço.
- **Feedback Imediato:** Cada ação do usuário é seguida por uma resposta imediata do sistema, como a confirmação de requisição, proporcionando clareza e confiança no processo.

### Design da Interface
- **Clareza Visual:** Uso de tipografia grande e botões bem definidos para facilitar a leitura e a interação, especialmente em ambientes de alta pressão como hospitais.
- **Consistência:** Elementos de interface consistentes em todas as telas ajudam os usuários a se familiarizarem rapidamente com o aplicativo, aumentando a eficiência e reduzindo a curva de aprendizado.

### Funcionalidades
- **Requisição de Medicamentos:** Permite aos enfermeiros adicionar rapidamente medicamentos necessários e indicar urgência.
- **Relato de Problemas Recorrentes:** Facilita a comunicação de problemas recorrentes com a opção de adicionar uma descrição detalhada.
- **Confirmação e Localização:** Fornece confirmação imediata e informações sobre o ponto de retirada dos medicamentos, economizando tempo do usuário.
- **Histórico de Requisições:** Mantém um registro organizado de requisições pendentes e enviadas para fácil acompanhamento e referência.
- **Comunicação via Chat:** A funcionalidade de chat melhora a comunicação e a resolução de problemas em tempo real, facilitando a coordenação entre a equipe.

## Considerações Finais
Este protótipo é uma ferramenta essencial para os enfermeiros e a farmácia central, projetada para simplificar e agilizar o processo de requisição de medicamentos e a resolução de problemas recorrentes no Pyxis. A experiência do usuário foi cuidadosamente planejada para ser intuitiva, eficiente e confiável, garantindo que os enfermeiros possam se concentrar no atendimento ao paciente sem complicações adicionais.

