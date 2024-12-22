terraform {
  backend "s3" {
    bucket         = "my-terraform-states-ai-chat-ui"
    region         = "us-east-1"
    key            = "EKS/terraform.tfstate"
    dynamodb_table = "terraform-locks-ai-chat-ui"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}
