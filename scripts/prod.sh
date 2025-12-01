#!/bin/bash

# Production deployment script for Acquio App
# This script starts the application in production mode with Neon Cloud Database

echo "\U0001f680 Starting Acquio App in Production Mode"
echo "==============================================="

# Check if .env.production exists
if [ ! -f .env.production ]; then
    echo "\u274c Error: .env.production file not found!"
    echo "   Please create .env.production with your production environment variables."
    exit 1
fi

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "\u274c Error: Docker is not running!"
    echo "   Please start Docker and try again."
    exit 1
fi

echo "\U0001f4e6 Building and starting production container..."
echo "   - Using Neon Cloud Database (no local proxy)"
echo "   - Running in optimized production mode"
echo ""

# Start production environment
docker compose -f docker-compose.prod.yml up --build -d

# Wait for DB to be ready (basic health check)
echo "\u23f3 Waiting for Neon Local to be ready..."
sleep 5

# Run migrations with Drizzle
echo "\U0001f4dc Applying latest schema with Drizzle..."
npm run db:migrate

echo ""
echo "\U0001f389 Production environment started!"
echo "   Application: http://localhost:3000"
echo "   Logs: docker logs acquio-app-prod"
echo ""
echo "Useful commands:"
echo "   View logs: docker logs -f acquio-app-prod"
echo "   Stop app: docker compose -f docker-compose.prod.yml down"