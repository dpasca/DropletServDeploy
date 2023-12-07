#!/bin/bash

# Script to set up a test Python application environment

# Define the test project directory
TEST_PROJECT_DIR=~/test_python_app

# Create the test project directory
mkdir -p $TEST_PROJECT_DIR
cd $TEST_PROJECT_DIR

# Check if a Python virtual environment exists and activate it
VENV_DIR=~/python_projects/venv
if [ -d "$VENV_DIR" ]; then
    echo "Activating Python virtual environment..."
    source $VENV_DIR/bin/activate
else
    echo "Python virtual environment not found. Please set up the Python environment first."
    exit 1
fi

# Install Flask for the test application
pip install flask gunicorn

# Create a simple Flask app for testing
echo "from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run()" > app.py

echo "Test Python application environment setup completed."

