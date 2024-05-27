from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def criar_pedido(self):
        headers = {"Authorization": "123"}
        self.client.post("/request/create", json={"productCode": ["003"], "urgent": False, "description": "Está em falta", "pixiesID":2 }, headers=headers)

    @task
    def pegar_pedido(self):
        headers = {"Authorization": "123"}
        self.client.get("/request/user", headers=headers)
