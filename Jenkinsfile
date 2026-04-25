pipeline {
    agent any

    environment {
        IMAGE_NAME = "react-vite-app"
        CONTAINER_NAME = "react-vite-app"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                    sh "docker run -d -p 80:5173 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
        
        stage('Cleanup') {
            steps {
                sh "docker image prune -f"
            }
        }
    }

    post {
        success {
            echo "Deployment successful! App is running in Docker container: ${CONTAINER_NAME}"
        }
        failure {
            echo 'Deployment failed. Check Docker logs.'
        }
    }
}