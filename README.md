# Full DevOps Project – CI/CD on AWS

This project presents a complete CI/CD pipeline built using DevOps tools and the AWS cloud. Its goal is to fully automate the process of building, testing, and deploying an application — in this case, my CV in PDF format, available online in both Polish and English versions.
---
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
## GitHub Configuration

### 1. Setting a webhook in repository
![git_webhhok](https://github.com/user-attachments/assets/f37a9b4b-e30c-48e1-8dee-7315f8262915)

### 2. Created a token
![git_token](https://github.com/user-attachments/assets/ebdd52a5-6bde-4998-b5d5-14fda4a9ebec)
---
## Jenkins Configuration
### 1. Plugin

![jen_plugin](https://github.com/user-attachments/assets/c9a178c5-50f2-4d76-98bf-7979bfa82748)

### 2. Credentials

![jen_ceredntials](https://github.com/user-attachments/assets/d58a055e-a3b4-4ad0-8776-9763081e675a)

#3. Multibranch pipeline configuration

![pipeline12](https://github.com/user-attachments/assets/ef428fc7-6f2e-4f5b-b3ca-56f943e1fbf5)
![jen_pipe22](https://github.com/user-attachments/assets/31c027f9-5eb1-4a54-a599-879c77ca6701)

---

## My steps and result of project
### Terraform init and apply
![terra_apply](https://github.com/user-attachments/assets/16acf046-f912-46c1-aa18-f8cc0c443083)


### Using sourcetree commit and push to Test branch
![source_commit](https://github.com/user-attachments/assets/61465f2b-2984-4a0f-a950-c5d25df4fd68)

### Jenkins automaticly turns on
![jen_testpipe](https://github.com/user-attachments/assets/e66b4cef-b16f-4ecc-91f8-f996161044f7)

### Merge Test branch with main
![git_merge](https://github.com/user-attachments/assets/6cdded74-71f0-4cbc-aa71-313abd220bf5)

### Jenkins automaticly turns on
![jen_pipemerge](https://github.com/user-attachments/assets/807a205a-49eb-4111-aac3-af822b4683ad)





