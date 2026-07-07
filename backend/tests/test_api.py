from fastapi.testclient import TestClient

from app.main import app


client = TestClient(app)


def test_health() -> None:
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {"status": "ok", "service": "Nexo API"}


def test_create_task() -> None:
    response = client.post(
        "/api/v1/tasks",
        json={"title": "Buy milk", "space": "household"},
    )

    assert response.status_code == 201
    body = response.json()
    assert body["title"] == "Buy milk"
    assert body["space"] == "household"
    assert body["completed"] is False
