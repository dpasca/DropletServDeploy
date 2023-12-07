#!/bin/bash

# Check if an application name was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <app_name>"
    exit 1
fi

APP_NAME=$1
APP_DIR="$HOME/$APP_NAME"

# Ensure www-data has access to traverse to the application directory
sudo chmod o+x /home/$USER
sudo chmod o+x $APP_DIR

# Script to set up Nginx as a web server and configure it for a Python application

# Update system packages
sudo apt update && sudo apt upgrade -y

# Install Nginx if not already installed
if ! command -v nginx &> /dev/null
then
    sudo apt install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
fi

# Fetch the server's public IP address
SERVER_IP=$(curl -s ifconfig.me)

# Check if a Python virtual environment exists
VENV_DIR=~/python_projects/venv
if [ ! -d "$VENV_DIR" ]; then
    echo "Python virtual environment not found. Please set up the Python environment first."
    exit 1
fi

# Install Gunicorn using the virtual environment if not already installed
source $VENV_DIR/bin/activate
if ! pip list | grep -q gunicorn; then
    pip install gunicorn
fi

# Create a Gunicorn systemd service file
SERVICE_FILE=/etc/systemd/system/${APP_NAME}_gunicorn.service
echo "[Unit]
Description=Gunicorn instance to serve $APP_NAME
After=network.target

[Service]
User=$USER
Group=www-data
WorkingDirectory=$APP_DIR
ExecStart=$VENV_DIR/bin/gunicorn --workers 3 --bind unix:$APP_DIR/$APP_NAME.sock -m 007 app:app

[Install]
WantedBy=multi-user.target" | sudo tee $SERVICE_FILE

sudo systemctl daemon-reload
sudo systemctl restart ${APP_NAME}_gunicorn
sudo systemctl enable ${APP_NAME}_gunicorn

# Configure Nginx to proxy requests to Gunicorn
NGINX_CONF=/etc/nginx/sites-available/$APP_NAME
echo "server {
    listen 80;
    server_name $SERVER_IP;

    location / {
        include proxy_params;
        proxy_pass http://unix:$APP_DIR/$APP_NAME.sock;
    }
}" | sudo tee $NGINX_CONF

# Check if the symbolic link already exists before creating it
if [ ! -L /etc/nginx/sites-enabled/$APP_NAME ]; then
    sudo ln -s /etc/nginx/sites-available/$APP_NAME /etc/nginx/sites-enabled
fi

sudo nginx -t && sudo systemctl reload nginx

# Allow HTTP traffic through the firewall (TODO: remove HTTP and add HTTPS ?)
sudo ufw allow 80/tcp

echo "Nginx web server setup for $APP_NAME completed."
