import app

def test_health_endpoint():
    client = app.app.test_client()
    response = client.get('/health')
    assert response.status_code == 200
    data = response.get_json()
    assert data['status'] == 'ok'

def test_info_endpoint_exists():
    client = app.app.test_client()
    response = client.get('/info')
    assert response.status_code == 200
