pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-west-2'
        CLUSTER_NAME = 'Cluster'
    }

    stages {
        stage('ecr repo url from terraform') {
            steps {
                dir('terraform') {
                    script {
                        env.ECR_PL_BASE = sh(script: "terraform output -raw ecr_cv_pl_url", returnStdout: true).trim()
                        env.ECR_EN_BASE = sh(script: "terraform output -raw ecr_cv_en_url", returnStdout: true).trim()
                    }
                }
            }
        }

        stage('set image tags') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: 'manual'
                    env.TAG = "v-${env.BUILD_NUMBER}"
                    env.ECR_PL = "${env.ECR_PL_BASE}:${env.TAG}"
                    env.ECR_EN = "${env.ECR_EN_BASE}:${env.TAG}"
                    echo "Polish ECR image: ${env.ECR_PL}"
                    echo "English ECR image: ${env.ECR_EN}"
                }
            }
        }

        stage('login to ecr') {
            steps {
                sh '''
                    echo "logging in to ecr pl"
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_PL_BASE

                    echo "logging in to ecr en"
                    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_EN_BASE
                '''
            }
        }

        stage('build and push polish cv') {
            steps {
                dir('docker/CV') {
                    sh '''
                        echo "building polish cv image"
                        docker build -t $ECR_PL .

                        echo "pushing to ecr pl"
                        docker push $ECR_PL
                    '''
                }
            }
        }

        stage('build and push english cv') {
            steps {
                dir('docker/EN_CV') {
                    sh '''
                        echo "building english cv image"
                        docker build -t $ECR_EN .

                        echo "pushing to ecr en"
                        docker push $ECR_EN
                    '''
                }
            }
        }

        stage('deploy to eks') {
            when {
                branch 'main'
            }
            environment {
                KUBECONFIG = "${WORKSPACE}/.kube/config"
            }
            steps {
                sh '''
                    echo "kubeconfig commands before deploy"
                    aws eks update-kubeconfig --name $CLUSTER_NAME --region $AWS_REGION

                    export KUBECONFIG=$WORKSPACE/.kube/config

                    aws sts get-caller-identity
                    kubectl get nodes

                    echo "deploying polish cv"
                    helm upgrade cv-pl k8s/helm-cv-chart \
                        --install \
                        --namespace default \
                        -f k8s/helm-cv-chart/values-pl.yaml \
                        --set image.repository=$ECR_PL_BASE \
                        --set image.tag=$TAG

                    echo "deploying english cv"
                    helm upgrade cv-en k8s/helm-cv-chart \
                        --install \
                        --namespace default \
                        -f k8s/helm-cv-chart/values-en.yaml \
                        --set image.repository=$ECR_EN_BASE \
                        --set image.tag=$TAG

                    echo "deployment complete"
                '''
            }
        }
    }
}
