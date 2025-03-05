Here is a proposed restructuring of the README.md file for GitDeployX:

---

# 🚀 GitDeployX: Automated GitHub Deployment & Service Restart

GitDeployX automates code deployment from GitHub and restarts application services like Nginx, Node.js, Python (Gunicorn), etc. after pulling the latest code. It also maintains backups and logs deployment history for easy tracking.

## 📌 Features
- Automatically pulls latest GitHub code upon execution
- Restarts application services (Nginx, Node.js, Python, etc.)
- Creates backups before deploying new changes
- Logs deployment details for tracking & debugging
- Configurable via a single config.env file
- Supports manual execution or GitHub Webhook automation

## 📂 Project Structure
```
📁 GitDeployX/
 ├── 📄 deploy.sh          # Main script to pull the latest code and restart services
 ├── 📄 setup.sh           # Installs dependencies & sets up the environment
 ├── 📄 config.env         # Configuration file for repo & service details
 ├── 📄 README.md          # Project documentation
 ├── 📄 .gitignore         # Excludes sensitive files
 ├── 📂 logs/              # Stores deployment logs
 ├── 📂 backup/            # Keeps old versions before deploying new code
```

## 🔧 Prerequisites
Before installing GitDeployX, ensure you have:
- Linux Server (Ubuntu/Debian/CentOS/macOS)
- Git Installed `sudo apt install git -y`
- A Running Web App (Node.js/Python/Nginx/etc.)
- Configured GitHub SSH Key (for private repositories)

## 🚀 Installation & Setup

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/Kirankumarvel/GitDeployX.git
cd GitDeployX
```

### 2️⃣ Configure Settings
Edit `config.env` and update your repository details and services to restart:

```bash
# GitHub Repository URL
REPO_URL="git@github.com:yourusername/your-repo.git"

# Branch to pull
BRANCH="main"

# Project Directory on the Server
PROJECT_DIR="/var/www/html/your-project"

# Services to Restart After Deployment
SERVICES=("nginx" "node" "gunicorn")  # Modify based on your setup
```

### 3️⃣ Make Scripts Executable
```bash
chmod +x deploy.sh setup.sh
```

### 4️⃣ Run Setup Script
```bash
./setup.sh
```

## ⚡ Usage

### Run Deployment Manually
```bash
./deploy.sh
```
This will:
- Pull the latest code from GitHub
- Create a backup of the current version
- Restart defined services

### 📅 Automate Deployment via GitHub Webhooks

#### Step 1: Start Webhook Listener
Use a Webhook Service (like GitHub Webhook) to trigger `deploy.sh` when a new commit is pushed.

Example webhook script:

```bash
#!/bin/bash
cd /path/to/GitDeployX
./deploy.sh >> logs/webhook.log 2>&1
```

Run it as a background process or set up a lightweight webhook server with Python:

```bash
pip install flask
```

Then create a file `webhook_server.py`:

```python
from flask import Flask, request
import os

app = Flask(__name__)

@app.route('/deploy', methods=['POST'])
def deploy():
    os.system("./deploy.sh")
    return "Deployment Triggered", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

Run the script:

```bash
python3 webhook_server.py &
```

Now, configure your GitHub Webhook:

1. Go to GitHub Repository → Settings → Webhooks
2. Add Payload URL → `http://your-server-ip:5000/deploy`
3. Set Content Type → `application/json`
4. Select Trigger → Just the push event
5. Click Add Webhook

Now, every push will automatically deploy the latest code! 🚀

## 🛠️ Troubleshooting

### ❌ Deployment Failed?
Run manually:

```bash
./deploy.sh
```

### ❌ Git Pull Permission Issue?
Check if the server has SSH access to the repo:

```bash
ssh -T git@github.com
```

If access is denied, add your server’s SSH key to GitHub:

```bash
cat ~/.ssh/id_rsa.pub
```
Copy and paste it into GitHub → Settings → SSH Keys.

## 🔄 Backup & Rollback
Before deployment, GitDeployX creates a backup of the existing codebase.

### 📝 To Restore a Previous Version
Navigate to the backup folder:

```bash
cd backup/
```

Extract a previous backup:

```bash
tar -xzf backup-YYYYMMDDHHMM.tar.gz -C /var/www/html/your-project
```

Restart services:

```bash
./deploy.sh
```

## 📜 Future Enhancements
- Add Slack/Email notifications after deployment
- Implement rollback in case of failure
- Support for Docker-based deployments
- Web-based UI for deployment tracking

## 📃 License
MIT License © 2025 Kiran Kumar 

