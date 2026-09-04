const request = require('supertest');
const app = require('./server');

describe('Frontend service endpoints', () => {
  test('GET /health returns 200 and status ok', async () => {
    const res = await request(app).get('/health');
    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe('ok');
  });

  test('GET /info returns 200', async () => {
    const res = await request(app).get('/info');
    expect(res.statusCode).toBe(200);
  });
});
