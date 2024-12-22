module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.project_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true


  # Auto mode configuration (commented for reference)
  # cluster_compute_config = {
  #   enabled    = true
  #   node_pools = ["general-purpose"]
  # }

  # Manual node group configuration with t2.medium

  eks_managed_node_groups = {
    general = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t2.medium"]
      capacity_type  = "ON_DEMAND"

      # Enable Systems Manager
      iam_role_additional_policies = {
        AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      }

      labels = {
        Environment = "test"
        NodeGroup  = "general"
      }
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = local.tags
}
