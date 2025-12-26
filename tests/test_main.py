from fastapi.testclient import TestClient
from src.main import app

client = TestClient(app)

def test_read_root():
    """
    Test the root endpoint to ensure it returns a 200 status code
    and the expected JSON message.
    """
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "MovieMoodReel AI is running!"}