# variables.tf
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.large"
}

variable "key_name" {
  type = string
  description = "Name of the SSH key pair"
}

variable "instance_name" {
  type    = string
  default = "Jenkins-Server"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
  
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
  
}