from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def criar_pedido(self):
        headers = {"Authorization": "123"}
        self.client.post("/requests/create", json={"name": "durateston", "description": "paciente querendo ficar grandão"}, headers=headers)

    @task
    def pegar_pedido(self):
        headers = {"Authorization": "123"}
        self.client.get("/requests/user", headers=headers)
