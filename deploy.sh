#!/bin/bash

# Load configuration
source config.env

# Timestamp for backups
TIMESTAMP=$(date +"%Y%m%d%H%M")
LOG_FILE="logs/deploy_$TIMESTAMP.log"

log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOG_FILE"
}

# Navigate to the project directory
cd "$PROJECT_DIR" || exit

# Backup current version
log_message "📌 Creating backup..."
tar -czf "../backup/backup-$TIMESTAMP.tar.gz" .

# Pull latest code
log_message "🚀 Pulling latest code from GitHub..."
git reset --hard && git pull origin "$BRANCH"

# Restart services
for SERVICE in "${SERVICES[@]}"; do
    log_message "🔄 Restarting $SERVICE..."
    case $SERVICE in
        nginx) sudo systemctl restart nginx ;;
        node)  pm2 restart all ;;
        gunicorn) sudo systemctl restart gunicorn ;;
        *) log_message "⚠️ Unknown service: $SERVICE" ;;
    esac
done

log_message "✅ Deployment successful!"
exit 0
