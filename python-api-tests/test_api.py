import requests

def test_get_user():
    r = requests.get("https://jsonplaceholder.typicode.com/users/1")
    assert r.status_code == 200
    assert r.json()["id"] == 1