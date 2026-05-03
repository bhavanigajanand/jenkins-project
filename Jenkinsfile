pipeline {
    agent any

    environment {
        IMAGE_NAME = "bhavanigajanand/jenkins-cicd-app"
        CONTAINER_NAME = "jenkins-cicd-app"
    }

    stages {

        stage('Clone Repository') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main',
                    url: 'https://github.com/bhavanigajanand/jenkins-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t $IMAGE_NAME ./app'
            }
        }

        stage('Push to DockerHub') {
            steps {
                echo 'Pushing image to DockerHub...'
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Deploy on EC2') {
            steps {
                echo 'Deploying on EC2...'
                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'ec2-ssh-key',
                        keyFileVariable: 'SSH_KEY',
                        usernameVariable: 'SSH_USER'
                    ),
                    string(credentialsId: 'ec2-public-ip', variable: 'EC2_IP')
                ]) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no -i $SSH_KEY $SSH_USER@$EC2_IP "
                            docker pull $IMAGE_NAME &&
                            docker stop $CONTAINER_NAME || true &&
                            docker rm $CONTAINER_NAME || true &&
                            docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME
                        "
                    '''
                }
            }
        }

    }

    post {
        success {
            echo '✅ Deployment successful! App is live.'
        }
        failure {
            echo '❌ Build failed! Check the logs.'
        }
    }
}

