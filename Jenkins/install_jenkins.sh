#!/bin/bash 
sudo yum update -y  
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo  
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key  
sudo yum upgrade -y 
sudo dnf install java-17-amazon-corretto -y  
sudo yum install jenkins -y  
sudo systemctl enable jenkins  
sudo systemctl start jenkins
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins
sudo yum install -y git
sudo docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community