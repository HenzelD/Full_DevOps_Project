module "s3_backend" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0"

  bucket = "dominik-terraform-state-full-devops-proj"

  versioning = {
    enabled = true
  }

  force_destroy = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}