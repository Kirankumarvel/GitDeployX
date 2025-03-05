#!/bin/bash

# Install dependencies
sudo apt update && sudo apt install -y git nginx pm2

# Create required directories
mkdir -p logs backup

# Set permissions
chmod +x deploy.sh

# Setup cron job for automation
echo "*/10 * * * * /path/to/GitDeployX/deploy.sh" | crontab -

echo "✅ Setup complete!"

# config.env
PROJECT_DIR="/var/www/myproject"
BRANCH="main"
SERVICES=("nginx" "node")
