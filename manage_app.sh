#!/bin/bash

# Check if sufficient arguments were provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <app_name> <start|stop>"
    exit 1
fi

APP_NAME=$1
ACTION=$2
SERVICE_NAME="${APP_NAME}_gunicorn"

# Start or stop the application
case $ACTION in
    start)
        echo "Starting $APP_NAME..."
        sudo systemctl start $SERVICE_NAME
        sudo systemctl enable $SERVICE_NAME
        sudo systemctl restart nginx
        ;;
    stop)
        echo "Stopping $APP_NAME..."
        sudo systemctl stop $SERVICE_NAME
        sudo systemctl disable $SERVICE_NAME
        sudo systemctl restart nginx
        ;;
    *)
        echo "Invalid action: $ACTION"
        echo "Usage: $0 <app_name> <start|stop>"
        exit 1
        ;;
esac

