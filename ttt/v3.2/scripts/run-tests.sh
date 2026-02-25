#!/bin/bash
set -e

IMAGE_NAME=$1
PORT=8080

echo "Starting container..."
docker run -d -p $PORT:80 --name test-container $IMAGE_NAME

echo "Waiting for container to be ready..."
sleep 10

echo "Checking application availability..."

for i in {1..10}; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT || echo "000")
  if [ "$STATUS" = "200" ]; then
    echo "✅ Application reachable"
    docker stop test-container
    exit 0
  fi
  echo "Waiting..."
  sleep 3
done

echo "❌ Application not reachable. HTTP Status: $STATUS"
docker logs test-container
docker stop test-container
exit 1
