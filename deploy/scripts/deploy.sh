#!/bin/bash
set -e

echo "Pulling latest image..."
docker compose pull

echo "Starting containers..."
docker compose up -d

echo "Running migrations..."
docker compose exec app rails db:prepare

echo "Deployment completed."
