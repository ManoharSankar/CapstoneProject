pipeline {
    agent any
    environment {
	     DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
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
		   withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
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

