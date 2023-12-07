#!/bin/bash

# Script to set up a non-root user and basic firewall settings

# Prompt for the new username
read -p "Enter the new username: " username

# Add the new user and ask for a password
adduser $username

# Grant sudo privileges to the new user
usermod -aG sudo $username

# Install and configure UFW (Uncomplicated Firewall)
apt update
apt install ufw -y

# Allow OpenSSH and enable the firewall
ufw allow OpenSSH
ufw --force enable

echo "User and security setup completed."

