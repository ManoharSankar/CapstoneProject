pipeline {
    agent any
    environment {
	DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
        DEV_REPO = "manoharms/reactapp-dev"
        PROD_REPO = "manoharms/reactapp-prod"
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

