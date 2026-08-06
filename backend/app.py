import os
import platform
import socket
import time
from datetime import datetime, timezone

from flask import Flask, jsonify

app = Flask(__name__)

SERVICE_NAME = "backend"
VERSION = os.environ.get("APP_VERSION", "1.0.0")
START_TIME = time.time()


@app.route("/health", methods=["GET"])
def health():
    return jsonify(
        status="ok",
        uptimeSeconds=int(time.time() - START_TIME),
    ), 200


@app.route("/info", methods=["GET"])
def info():
    return jsonify(
        service=SERVICE_NAME,
        version=VERSION,
        hostname=socket.gethostname(),
        platform=platform.platform(),
        pythonVersion=platform.python_version(),
        timestamp=datetime.now(timezone.utc).isoformat(),
    ), 200


@app.route("/", methods=["GET"])
def root():
    return f"Hello from {SERVICE_NAME} v{VERSION}. Try /health or /info", 200


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
