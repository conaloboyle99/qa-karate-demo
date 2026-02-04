#!/bin/bash
# -------------------------------------------------
# One-command QA run: Clean, Build, Run Karate + Cypress
# -------------------------------------------------

# Stop and remove any old containers, including orphans
docker compose down --remove-orphans

# Build images (uses cache for Maven)
docker compose build

# Run both services and stream logs
docker compose up
