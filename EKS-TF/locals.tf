locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Project    = var.project_name

  }
}
