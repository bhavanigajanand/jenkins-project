pipeline {
    agent any

    environment {
        IMAGE_NAME = "jenkins-cicd-app"
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

        stage('Stop Old Container') {
            steps {
                echo 'Stopping old container if running...'
                sh '''
                    cd app
                    docker-compose down || true
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying new container...'
                sh '''
                    cd app
                    docker-compose up -d
                '''
            }
        }

    }

    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Build failed!'
        }
    }
}
