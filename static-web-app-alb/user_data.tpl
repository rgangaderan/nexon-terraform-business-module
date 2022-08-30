#!/bin/bash

# Update and install Docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y 
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y 



# Instanll AWS CLI to access S3 Bucket for copy artifacts #
sudo apt install awscli -y

name=$(aws secretsmanager get-secret-value --secret-id "${user_secret_key}" --region ${region} --query SecretString | tr -d \")
password=$(aws secretsmanager get-secret-value --secret-id "${password_secret_key}" --region ${region} --query SecretString | tr -d \")


# Docker Login

echo $password | sudo docker login -u $name --password-stdin

# Docker Pull

sudo docker pull ${dockerhub_repo}:${version}

sudo docker run -d -p 80:80 --name webapp ${dockerhub_repo}:${version}
