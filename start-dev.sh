#!/bin/bash

echo "=== Morning Startup Script: Docker + Jenkins + Node ==="

# --- 1️⃣ Start Docker Desktop if not running ---
if ! pgrep -x "Docker" > /dev/null; then
    echo "🚀 Starting Docker Desktop..."
    open -a Docker
    echo "⏳ Waiting for Docker to be ready..."
    while ! docker info > /dev/null 2>&1; do
        sleep 2
    done
else
    echo "✅ Docker is already running."
fi

# --- 2️⃣ Check Node/NPM ---
if ! command -v node > /dev/null; then
    echo "❌ Node is not installed. Install with: brew install node"
    exit 1
fi
if ! command -v npm > /dev/null; then
    echo "❌ NPM not found. Ensure Node is installed correctly."
    exit 1
fi
echo "✅ Node and NPM available. Node version: $(node -v)"

# --- 3️⃣ Start Jenkins service ---
if ! brew services list | grep jenkins-lts | grep started > /dev/null; then
    echo "🚀 Starting Jenkins..."
    brew services start jenkins-lts
else
    echo "✅ Jenkins already running."
fi

# --- 4️⃣ Optional: Verify Jenkins URL ---
echo "🌐 Jenkins should be available at http://localhost:8080"

echo "✅ All systems ready. You can now run your pipeline!"
