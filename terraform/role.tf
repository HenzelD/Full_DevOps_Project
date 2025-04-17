module "eks_cluster_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  role_name = "my-eks-cluster-role"
  create_role = true
  role_requires_mfa = false

  trusted_role_services = [
    "eks.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]
}
module "node_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  role_name = "node_role"
  create_role = true
  role_requires_mfa = false

  trusted_role_services = [
    "eks.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

module "jenkins_ec2_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  role_name           = "jenkins-ec2-ecr-role"
  create_role         = true
  role_requires_mfa   = false

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  ]

  tags = {
    Name        = "jenkins-ec2-role"
    Environment = "dev"
  }
}

