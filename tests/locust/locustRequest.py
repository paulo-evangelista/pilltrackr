from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def criar_pedido(self):
        self.client.post("/requests", json={"name": "durateston",  "description": "paciente querendo ficar grandão" })

    @task
    def pegar_pedido(self):
        self.client.get(f"/requests")