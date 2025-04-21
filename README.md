# Full DevOps Project – CI/CD na AWS

Ten projekt przedstawia kompletny pipeline CI/CD zbudowany w oparciu o narzędzia DevOps i chmurę AWS. Jego celem jest pełna automatyzacja procesu budowy, testowania i wdrażania aplikacji — w tym przypadku: moje CV w formacie PDF, dostępne online w wersji polskiej i angielskiej.

## Stack technologiczny

- **Terraform** – provisioning infrastruktury w AWS (EKS, IAM, ECR)
- **Jenkins** – automatyzacja pipeline CI/CD
- **Docker** – budowanie i konteneryzacja aplikacji
- **Helm** – zarządzanie wdrożeniami w Kubernetesie
- **AWS EKS** – zarządzany klaster Kubernetes
- **AWS ECR** – prywatny rejestr kontenerów
- **GitHub** – zarządzanie kodem źródłowym i webhooki

---

## Przepływ CI/CD

1. **Push do GitHub** (np. `main`)
2. **Jenkins**:
   - Buduje obraz Dockera z aplikacją (CV hostowane przez Nginx)
   - Wysyła obraz do **ECR**
   - Jeśli to `main` → deploy do EKS przez Helm
3. **EKS**:
   - Tworzy Load Balancer
   - Aplikacja dostępna publicznie:
     - `http://example.com/` → CV po polsku
     - `http://example.com:81/` → CV po angielsku
---

## 🚀 Jak uruchomić projekt lokalnie

1. Zainstaluj:
   - Terraform
   - Docker
   - AWS CLI + skonfiguruj poświadczenia (`aws configure`)
2. Utwórz infrastrukturę:
   ```bash
   cd terraform
   terraform init
   terraform apply
graph TD
    GitHub --> Jenkins
    Jenkins --> Docker[Build Docker Image]
    Docker --> ECR[Push to ECR]
    ECR --> Helm[Deploy via Helm]
    Helm --> EKS
    EKS --> LB[Load Balancer]
    LB --> CV[Public CV App]


