A aplicação Mobile é desenvolvida em Flutter com o uso da linguagem Dart. Com o framework Flutter é possível desenvolver aplicações multiplataformas com a mesma base de código. Para nosso aplicativo, dividimos em 2 fluxos de telas principais, um para o usuário da Enfermaria e outro para o da Farmácia Central.

## Views

### Enfermeiro

1. **Tela de Escolha:** A tela inicial onde o enfermeiro escolhe o motivo da requisição.

2. **Tela de Medicamentos:** Formulário para o enfermeiro requisitar medicamentos.

3. **Tela de Outros:** Formulário para o enfermeiro requisitar outros tipos de problemas.

4. **Tela de Feedback de Sucesso:** Feedback após a criação de uma nova requisição com sucesso.

5. **Tela de Requisições Feitas:** Lista de requisições feitas pelo enfermeiro.
   
### Farmácia Central

1. **Tela de Requisições Pendentes:** Lista de requisições pendentes para serem processadas pela farmácia central.

2. **Tela de Detalhe da Requisição Pendente:** Detalhamento de uma requisição específica.
   
3. **Tela de Requisições Enviadas:** Lista de requisições enviadas pela farmácia central.
   
## Fluxo de Telas

### Enfermeiro

1. **Tela de Escolha**
   - O enfermeiro inicia na tela de escolha e seleciona o motivo da requisição.
   - Ao selecionar "Medicamentos" ou "Outros" e clicar em "Entrar", é direcionado para a respectiva tela de formulário.

2. **Tela de Medicamentos**
   - O enfermeiro preenche o formulário com os detalhes necessários e clica em "Enviar".
   - Após o envio, é direcionado para a tela de feedback de sucesso.

3. **Tela de Outros**
   - O enfermeiro preenche o formulário com os detalhes necessários e clica em "Enviar".
   - Após o envio, é direcionado para a tela de feedback de sucesso.

4. **Tela de Feedback de Sucesso**
   - Após ver a confirmação de sucesso, o enfermeiro pode clicar em "Entrar" para acompanhar as requisições.
   - É direcionado para a tela de requisições feitas.

5. **Tela de Requisições Feitas**
   - O enfermeiro pode visualizar a lista de requisições feitas e editar ou visualizar detalhes de cada uma.

### Farmácia Central

1. **Tela de Requisições Pendentes**
   - A farmácia central inicia na tela de requisições pendentes.
   - Pode visualizar ou editar detalhes de cada requisição pendente.

2. **Tela de Detalhe da Requisição Pendente**
   - Ao visualizar uma requisição, pode adicionar informações adicionais e enviar a requisição.

3. **Tela de Requisições Enviadas**
   - Após enviar uma requisição, a farmácia central pode visualizar a lista de requisições enviadas e editar ou visualizar detalhes de cada uma.

Este fluxo de telas garante que tanto os enfermeiros quanto a farmácia central possam gerenciar eficientemente as requisições de medicamentos e outros problemas recorrentes.