module "ecr_cv_pl" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "cv-pl"

  repository_read_write_access_arns = [module.jenkins_ec2_role.iam_role_arn]

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  depends_on = [module.jenkins_ec2_role.tf]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ecr_cv_en" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "cv-en"

  repository_read_write_access_arns = [module.jenkins_ec2_role.iam_role_arn]

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  depends_on = [module.jenkins_ec2_role.tf]
  
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

output "ecr_cv_pl_url" {
  value = module.ecr_cv_pl.repository_url
}

output "ecr_cv_en_url" {
  value = module.ecr_cv_en.repository_url
}
