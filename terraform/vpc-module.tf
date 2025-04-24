module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 5.19.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs = var.vpc_az
  private_subnets     = var.vpc_private_subnets
  public_subnets      = var.vpc_public_subnets

  private_subnet_tags = {
  Name                             = "Private-Subnet"
  "kubernetes.io/role/internal-elb" = "1"
  "kubernetes.io/cluster/Cluster" = "owned"
  }

  public_subnet_tags = {
  Name                           = "Public-Subnet"
  "kubernetes.io/role/elb"         = "1"
  "kubernetes.io/cluster/Cluster" = "owned"
  }
  map_public_ip_on_launch = true


  
  enable_nat_gateway = true
  single_nat_gateway  = true

  enable_dns_hostnames = true

  database_subnet_tags = {
    Name = "DB-Subnet"
  }
  vpc_tags = {
    Name = "${var.vpc_name}"
  }
  tags = {
    Owner = "Dominik"
    Environment = "Test"
  }
}