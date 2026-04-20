#!/bin/bash
set -e

# Determine which service to run.
# Set SERVICE=frontend to deploy the frontend; defaults to backend.
SERVICE="${SERVICE:-backend}"

echo "Starting service: $SERVICE"

if [ "$SERVICE" = "frontend" ]; then
  echo "Installing frontend dependencies..."
  cd frontend
  npm install --production=false

  # If a production build exists, serve it; otherwise start the dev server.
  if [ -d "build" ]; then
    echo "Serving pre-built frontend on port ${PORT:-3000}..."
    npx serve -s build -l "${PORT:-3000}"
  else
    echo "Starting frontend dev server on port ${PORT:-3000}..."
    PORT="${PORT:-3000}" npm start
  fi

else
  echo "Installing backend dependencies..."
  cd backend
  npm install

  echo "Starting backend server on port ${PORT:-5000}..."
  PORT="${PORT:-5000}" npm start
fi
