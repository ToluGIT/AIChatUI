# backend.tf
terraform {
  backend "s3" {
    bucket         = "my-terraform-states-ai-chat-ui"
    region         = "us-east-1"
    key            = "EKS/terraform.tfstate"
    dynamodb_table = "terraform-locks-ai-chat-ui"
    encrypt        = true
  }
}
