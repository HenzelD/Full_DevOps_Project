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

## Requirements:
- AWS account 
- Terraform
- Jenkins

## GitHub Configuration

1. Setting a webhook in repository
![git_webhhok](https://github.com/user-attachments/assets/f37a9b4b-e30c-48e1-8dee-7315f8262915)
2. Created a token
![git_token](https://github.com/user-attachments/assets/ebdd52a5-6bde-4998-b5d5-14fda4a9ebec)

## Jenkins Configuration
1. Plugin

![jen_plugin](https://github.com/user-attachments/assets/c9a178c5-50f2-4d76-98bf-7979bfa82748)

2. Credentials

![jen_ceredntials](https://github.com/user-attachments/assets/d58a055e-a3b4-4ad0-8776-9763081e675a)

3. Multibranch pipeline configuration

![pipeline12](https://github.com/user-attachments/assets/ef428fc7-6f2e-4f5b-b3ca-56f943e1fbf5)
![jen_pipe22](https://github.com/user-attachments/assets/31c027f9-5eb1-4a54-a599-879c77ca6701)




