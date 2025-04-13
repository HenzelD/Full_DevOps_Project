#!/bin/bash

echo "➡️ Migrating state to remote S3 backend..."

cat > backend.tf <<EOF
terraform {
  backend "s3" {
    bucket = "dominik-terraform-state-full-devops-proj"
    key    = "terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
  }
}
EOF

terraform init -force-copy
