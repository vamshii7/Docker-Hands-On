#!/bin/bash
set -e

IMAGE_NAME=$1
PORT=8080

echo "Starting container..."
docker run -d -p $PORT:80 --name test-container $IMAGE_NAME

echo "Waiting for container to be ready..."
sleep 10

echo "Checking application availability..."

STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT)

if [ "$STATUS" != "200" ]; then
  echo "❌ Application not reachable. HTTP Status: $STATUS"
  docker logs test-container
  docker stop test-container
  exit 1
fi

echo "✅ Application reachable"

docker stop test-container
