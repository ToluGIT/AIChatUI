output "jenkins_url" {
  value = "http://${aws_instance.jenkins_server.public_ip}:8080"
}

output "sonarqube_url" {
  value = "http://${aws_instance.jenkins_server.public_ip}:9000"
}

output "instance_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "jenkins_initial_password_command" {
  value = "ssh -i <your-key.pem> ec2-user@${aws_instance.jenkins_server.public_ip} 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword'"
}