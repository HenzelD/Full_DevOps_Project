module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "Cluster"
  cluster_version = "1.31"

  authentication_mode = "API"

  access_entries = {
    jenkins = {
      principal_arn = "arn:aws:iam::713881808991:role/jenkins-ci-cd-role"

      policy_associations = {
        admin-access = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.public_subnets[0],
    module.vpc.private_subnets[1],
    module.vpc.public_subnets[1]
  ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
