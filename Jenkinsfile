pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-central-1'
    }

    stages {
        stage('Terraform init (read S3 backend)') {
            steps {
                dir('terraform') {
                    sh '''
                        echo "🔁 Initializing Terraform with remote S3 backend (only if needed)..."
                        terraform init -input=false -no-color
                    '''
                }
            }
        }

        stage('Get ECR repo URLs from Terraform') {
            steps {
                dir('terraform') {
                    script {
                        def ecrPl = sh(script: "terraform output -raw ecr_cv_pl_url", returnStdout: true).trim()
                        def ecrEn = sh(script: "terraform output -raw ecr_cv_en_url", returnStdout: true).trim()
                        env.ECR_PL = ecrPl
                        env.ECR_EN = ecrEn
                        echo "📦 Polish ECR repo: ${env.ECR_PL}"
                        echo "📦 English ECR repo: ${env.ECR_EN}"
                    }
                }
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                    echo "🔐 Logging in to ECR (PL)..."
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_PL

                    echo "🔐 Logging in to ECR (EN)..."
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_EN
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
    }
}
