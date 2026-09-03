#!/bin/bash
echo "Hitting Kong-proxied frontend endpoint 10 times..."
for i in $(seq 1 10); do
  code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000/health)
  echo "Request $i: HTTP $code"
  sleep 0.2
done
