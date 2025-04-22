# Full DevOps Project – CI/CD on AWS

This project presents a complete CI/CD pipeline built using DevOps tools and the AWS cloud. Its goal is to fully automate the process of building, testing, and deploying an application — in this case, my CV in PDF format, available online in both Polish and English versions.

## Used Technologies

- **Terraform** – building infrastructure in AWS (EKS, IAM, ECR, VPC)
- **Jenkins** – CI/CD pipeline automation  
- **Docker** – application building and containerization  
- **Helm** – Kubernetes deployment management  
- **AWS EKS** – managed Kubernetes cluster  
- **AWS ECR** – private container registry  
- **GitHub** – source code management and webhooks  

---

## CI/CD

1. **Push to GitHub** (Test or main branch)
2. **Jenkins**:
   - Builds a Docker image with the application (CV hosted by Nginx)
   - Pushes the image to **ECR**
   - If it's a `main` push → deploys to EKS using Helm
3. **EKS**:
   - Creates a Load Balancer
---
## Requirements:
- AWS account 
- Terraform
- Jenkins
---
## How to Run the Project Locally

1. Install:
   - Terraform
   - AWS CLI + run command (`aws configure`)
2. Clone repository:
   ```bash
   git clone https://github.com/HenzelD/Full_DevOps_Project.git
   cd terraform
   terraform init
   terraform apply

