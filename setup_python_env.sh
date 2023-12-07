#!/bin/bash

# Script to set up Python environment

# Update system packages
sudo apt update && sudo apt upgrade -y

# Install Python and pip
sudo apt install python3 python3-pip -y

sudo apt install python3.11-venv -y

# Create a project directory (modify as needed)
mkdir -p ~/python_projects
cd ~/python_projects

# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install virtualenv within the virtual environment
pip install virtualenv
# Install Flask within the virtual environment
pip install flask

echo "Python environment setup completed."

