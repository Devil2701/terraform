#!/bin/bash
sudo apt-get update -y
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo apt-get install unzip -y
sudo wget https://www.free-css.com/assets/files/free-css-templates/download/page284/maker.zip
sudo unzip maker.zip
sudo mv maker/* /var/www/html
