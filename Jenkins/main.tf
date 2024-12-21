resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sonar-sg"
  description = "Security group for Jenkins and SonarQube"
  vpc_id      = aws_vpc.jenkins_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sonar-sg"
  }
}

resource "aws_instance" "jenkins_server" {
  ami                         = "ami-01816d07b1128cd2d"  # Specific Amazon Linux AMI
  instance_type              = var.instance_type
  key_name                   = var.key_name
  subnet_id                  = aws_subnet.jenkins_subnet.id
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  root_block_device {
    volume_size = 30
  }

  user_data = file("install_jenkins.sh")

  tags = {
    Name = var.instance_name
  }
}