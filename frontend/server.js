const express = require('express');
const os = require('os');

const app = express();
const PORT = process.env.PORT || 3000;
const SERVICE_NAME = 'frontend';
const VERSION = process.env.APP_VERSION || '1.0.0';
const START_TIME = Date.now();

app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    uptimeSeconds: Math.floor((Date.now() - START_TIME) / 1000),
  });
});

app.get('/info', (req, res) => {
  res.status(200).json({
    service: SERVICE_NAME,
    version: VERSION,
    hostname: os.hostname(),
    platform: os.platform(),
    nodeVersion: process.version,
    backendUrl: process.env.BACKEND_URL || 'not-configured',
    timestamp: new Date().toISOString(),
  });
});

app.get('/', (req, res) => {
  res.status(200).send(`Hello from ${SERVICE_NAME} v${VERSION}. Try /health or /info`);
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`[${SERVICE_NAME}] listening on port ${PORT}`);
});
