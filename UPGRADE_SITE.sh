#!/bin/bash

# JOKIBO Website Premium Upgrade Deployment Script
# This script swaps the current basic design with the new premium V2 design.

PROJECT_ROOT="/home/hannington/JOKIBO Interior Design Website"
BRAIN_DIR="/home/hannington/.gemini/antigravity/brain/50b7f045-087b-44a9-a236-c8fa6c5219de"

echo "Starting Premium Upgrade..."

# 1. Create backups of current design
echo "Backing up current design..."
mv "$PROJECT_ROOT/templates" "$PROJECT_ROOT/templates_v1_backup"
mv "$PROJECT_ROOT/static" "$PROJECT_ROOT/static_v1_backup"

# 2. Deploy v2 templates
echo "Deploying new templates..."
mkdir -p "$PROJECT_ROOT/templates"
cp "$PROJECT_ROOT/v2/templates/"* "$PROJECT_ROOT/templates/"

# 3. Deploy v2 static structure and assets
echo "Deploying new static assets..."
mkdir -p "$PROJECT_ROOT/static/img"

# Copy generated luxury images from the brain
cp "$BRAIN_DIR/luxury_living_room_1773436829995.png" "$PROJECT_ROOT/static/img/portfolio-1.png"
cp "$BRAIN_DIR/modern_kitchen_interior_1773436861689.png" "$PROJECT_ROOT/static/img/portfolio-2.png"
cp "$BRAIN_DIR/serene_bedroom_suite_1773436896503.png" "$PROJECT_ROOT/static/img/portfolio-3.png"

echo "Upgrade complete. Please restart your Flask server if it doesn't auto-reload."
echo "Visit your site to see the new JOKIBO premium experience!"
