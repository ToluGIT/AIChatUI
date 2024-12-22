#!/bin/bash 


sudo yum update -y  


sudo fuser -k 8080/tcp || true
sudo pkill -f jenkins || true
sudo rm -f /var/run/jenkins.pid
sudo rm -rf /var/cache/jenkins/*


sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo  
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key  
sudo yum upgrade -y 
sudo dnf install java-17-amazon-corretto -y  
sudo yum install jenkins -y  


sudo mkdir -p /etc/systemd/system/jenkins.service.d/


sudo tee /etc/systemd/system/jenkins.service.d/override.conf << EOL
[Service]
Environment="JENKINS_HOME=/var/lib/jenkins"
Environment="JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto"
User=jenkins
ExecStartPre=/bin/rm -f /var/run/jenkins.pid
ExecStartPre=/bin/bash -c '/usr/bin/fuser -k 8080/tcp || true'
EOL

sudo systemctl daemon-reload
sudo systemctl enable jenkins  
sudo systemctl start jenkins


sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins


sudo yum install -y git

curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh  -s -- -b /usr/local/bin v0.18.3

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

# Wait for Jenkins to release the port before starting SonarQube
sleep 30

# Start SonarQube
sudo docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community

echo "Checking service status..."
sudo systemctl status jenkins
sudo docker ps


echo "Jenkins initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
