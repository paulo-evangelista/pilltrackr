from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def criar_usuario(self):
        self.client.post("/users", json={"email": "vitor@gmail.com",  "password": "123@vitor" })
