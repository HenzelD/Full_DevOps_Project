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

### 3. Multibranch pipeline configuration

![pipeline12](https://github.com/user-attachments/assets/ef428fc7-6f2e-4f5b-b3ca-56f943e1fbf5)
![jen_pipe22](https://github.com/user-attachments/assets/31c027f9-5eb1-4a54-a599-879c77ca6701)

---

## My steps and result of project
### Terraform init and apply
![terra_apply](https://github.com/user-attachments/assets/e9142a30-3c5b-4d06-9932-d0f9e0895c0e)

---
### Using sourcetree commit and push to Test branch
![source_commit_readmetest](https://github.com/user-attachments/assets/b726decf-5b31-41b1-a669-3d2d14c068d7)

---
### Jenkins automaticly turns on
![jen_testsuc](https://github.com/user-attachments/assets/565e4a1d-9828-41f2-88f6-56a67139ab54)

---
### Merge Test branch with main
![git_merge](https://github.com/user-attachments/assets/1ac07bd9-665a-4c3b-be39-9a22481f0b0c)

---
### Jenkins automaticly turns on
![jen_mergesuc](https://github.com/user-attachments/assets/585b45b7-d0e1-4f24-91f9-feccec853ec5)

---
### DNS of loadbalancers
![jen_loadbala](https://github.com/user-attachments/assets/ab71c3e7-ee19-4f6e-bbf1-60683d6fac3b)

---
### Resul CV PL
![cvpl](https://github.com/user-attachments/assets/0498b08b-d175-4ed3-9f40-5438f511eb22)

---
### Resul CV EN
![cven](https://github.com/user-attachments/assets/152ce29d-0329-4b4c-87b5-79e0832c8593)

---
### Change for different pdf in CV EN
![source_change_ENCV](https://github.com/user-attachments/assets/8495ba9b-a842-469e-8074-8ea25bb6d6ca)

---
### Jenkins automaticly turns on
![jen_cven_test](https://github.com/user-attachments/assets/1f7fdc26-84bb-4761-927a-e6504e72865d)

---
### Merge Test branch with main
![git_merge_ENCV](https://github.com/user-attachments/assets/1d277925-5383-4488-948f-92974e51af36)

---
### Jenkins automaticly turns on
![jen_cven_merge](https://github.com/user-attachments/assets/94b50618-dd12-45a7-b92b-73b35fead82c)

---
### Resul CV EN
![cven_change](https://github.com/user-attachments/assets/caa43e15-9a12-45d6-a466-94ce3fb022e9)











