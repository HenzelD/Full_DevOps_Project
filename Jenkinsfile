pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-west-2'
        CLUSTER_NAME = 'Cluster'
    }

    stages {

        stage('Pozdro  koniec essa Terraform init (read S3 backend)') {
            steps {
                dir('terraform') {
                    sh '''
                        echo "🔁 Initializing Terraform with remote S3 backend (only if needed)..."
                        terraform init -input=false -no-color
                    '''
                }
            }
        }
        stage('Refresh Terraform state') {
            steps {
                dir('terraform') {
                    sh 'terraform refresh -input=false -no-color'
                }
            }
        }
        stage('Get ECR repo URLs from Terraform') {
            steps {
                dir('terraform') {
                    script {
                        env.ECR_PL_BASE = sh(script: "terraform output -raw ecr_cv_pl_url", returnStdout: true).trim()
                        env.ECR_EN_BASE = sh(script: "terraform output -raw ecr_cv_en_url", returnStdout: true).trim()
                    }
                }
            }
        }

        stage('Set image tags') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: 'manual'
                    env.TAG = (branch == 'main') ? 'latest' : "v-${env.BUILD_NUMBER}"

                    env.ECR_PL = "${env.ECR_PL_BASE}:${env.TAG}"
                    env.ECR_EN = "${env.ECR_EN_BASE}:${env.TAG}"

                    echo "📦 Polish ECR image: ${env.ECR_PL}"
                    echo "📦 English ECR image: ${env.ECR_EN}"
                }
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                    echo "🔐 Logging in to ECR (PL)..."
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_PL_BASE

                    echo "🔐 Logging in to ECR (EN)..."
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_EN_BASE
                '''
            }
        }

        stage('Build & Push Polish CV') {
            steps {
                dir('docker/pl') {
                    sh '''
                        echo "🚧 Building Polish CV image..."
                        docker build -t $ECR_PL .

                        echo "🚀 Pushing to ECR (PL)..."
                        docker push $ECR_PL
                    '''
                }
            }
        }

        stage('Build & Push English CV') {
            steps {
                dir('docker/en') {
                    sh '''
                        echo "🚧 Building English CV image..."
                        docker build -t $ECR_EN .

                        echo "🚀 Pushing to ECR (EN)..."
                        docker push $ECR_EN
                    '''
                }
            }
        }

        stage('Deploy to EKS') {
            when {
                branch 'main'
            }
            environment {
                KUBECONFIG = "${WORKSPACE}/.kube/config"
            }
            steps {
                sh '''
                    echo "📡 Updating kubeconfig for EKS..."
                    aws eks update-kubeconfig --name $CLUSTER_NAME --region $AWS_REGION

                    echo "🚀 Deploying Polish CV..."
                    helm upgrade cv-pl k8s/helm-cv-chart \
                        --install \
                        --namespace default \
                        -f k8s/helm-cv-chart/values-pl.yaml \
                        --set image.repository=$ECR_PL_BASE \
                        --set image.tag=$TAG

                    echo "🚀 Deploying English CV..."
                    helm upgrade cv-en k8s/helm-cv-chart \
                        --install \
                        --namespace default \
                        -f k8s/helm-cv-chart/values-en.yaml \
                        --set image.repository=$ECR_EN_BASE \
                        --set image.tag=$TAG

                    echo "✅ Deployment complete!"
                '''
            }
        }
    }
}
