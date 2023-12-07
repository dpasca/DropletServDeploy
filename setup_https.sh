#!/bin/bash

# Script to set up HTTPS using Let's Encrypt and Certbot for Nginx

# Install Certbot and its Nginx plugin
sudo apt update
sudo apt install certbot python3-certbot-nginx -y

# Input the domain name
read -p "Enter your domain name: " domain_name

# Obtain and install the SSL certificate
sudo certbot --nginx -d $domain_name

# Reload Nginx to apply changes
sudo systemctl reload nginx

echo "HTTPS setup completed for $domain_name."

