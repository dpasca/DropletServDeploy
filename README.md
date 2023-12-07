# Deploying a Python App on a web server

Simple scripts and notes for deploying a Python app on a new machine.

## Run Order

1. `setup_user_security.sh`
2. `setup_python_env.sh`
3. `setup_web_server.sh test_python_app`
4. `source ~/python_projects/venv/bin/activate`
4. `setup_test_app.sh`


## Random Notes

```
sudo chown :www-data /home/davide/test_python_app/test_python_app.sock
sudo chmod 660 /home/davide/test_python_app/test_python_app.sock
```

Remember, when you want to work on your Python projects, you'll need to activate the virtual environment with source `~/python_projects/venv/bin/activate`

```
sudo rm /etc/nginx/sites-enabled/myapp
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl reload nginx
sudo systemctl status nginx
```

```
sudo ln -s /etc/nginx/sites-available/app_chatai /etc/nginx/sites-enabled/
```
