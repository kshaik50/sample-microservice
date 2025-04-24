pipeline {
  agent any

  tools {
    nodejs 'node18'  // Make sure you configured this in Jenkins > Tools
  }

  environment {
    REGISTRY = 'docker.io/kshaik50'      // 🔁 Replace with your actual Docker Hub username
    IMAGE_NAME = 'react-frontend'
  }

  stages {
    stage('Build & Test') {
      steps {
        echo '📦 Installing dependencies and building React app...'
        sh 'npm install'
        sh 'npm run build'
      }
    }

    stage('Docker Build & Push') {
      steps {
        echo '🐳 Building Docker image and pushing to registry...'
        withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh 'docker build -t $REGISTRY/$IMAGE_NAME:dev .'
          sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
          sh 'docker push $REGISTRY/$IMAGE_NAME:dev'
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        echo '☸️ Deploying to Kubernetes...'
        sh 'kubectl apply -f k8s/dev-deployment.yaml'
      }
    }
  }
}
