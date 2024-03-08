pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE_NAME = 'python-app'
        DOCKERFILE_PATH = './python/Dockerfile'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(env.DOCKER_IMAGE_NAME, "-f ${env.DOCKERFILE_PATH} .")
                }
            }
        }
    }
    
    post {
        success {
            echo 'Docker image built successfully!'

        }
        failure {
            echo 'Failed to build Docker image'
        }
    }
}

