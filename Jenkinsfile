pipeline {
    agent any
    environment {
	     DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
         
    }
    stages {
	/*stage('Checkout') {
            steps {
                // Clone the GitHub repository
                git branch: '${env.BRANCH_NAME}', url: 'https://github.com/ManoharSankar/CapstoneProject.git'
            }
        }*/
        stage('Build') {
            steps {
                script {
                    def BRANCH = env.GIT_BRANCH
                    echo "The branch that triggerd the build :${BRANCH}"
		   withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASS')]) {
                        
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASS'
           }
                    sh './build.sh ${BRANCH}'
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

