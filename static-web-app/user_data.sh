#!/bin/bash

# Update and install apache web server
sudo apt-get update && sudo apt-get install apache2 -y

# Instanll AWS CLI to access S3 Bucket for copy artifacts #
sudo apt install awscli -y
sudo -i

# Copy artifact for web application #

aws s3 cp s3://aritifacts-nexon-app/index.html /var/www/html/
