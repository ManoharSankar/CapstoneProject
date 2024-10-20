pipeline {
    agent any
    environment {
	DOCKERHUB_USERNAME = credentials('DOCKER_USERNAME')  // Jenkins credentials for Docker Hub
        DOCKERHUB_PASSWORD = credentials('DOCKER_PASS')
    }
    stages {
	stage('Checkout') {
            steps {
                // Clone the GitHub repository
                git branch: 'dev', url: 'https://github.com/ManoharSankar/CapstoneProject.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    sh './build.sh'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh './deploy.sh'
                }
            }
        }
    }
    post {
        success {
            echo "Build and Deployment Successful!"
        }
        failure {
            echo "Build or Deployment Failed."
        }
    }
}

