pipeline {
  agent any

  environment {
    REGISTRY = 'docker.io/kshaik50'        // 🔁 Replace with your Docker Hub username
    IMAGE_NAME = 'react-frontend'               // 🧠 This is your app's image name
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
        echo '🐳 Building and pushing Docker image...'
        withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh 'docker build -t $REGISTRY/$IMAGE_NAME:dev .'
          sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
          sh 'docker push $REGISTRY/$IMAGE_NAME:dev'
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        echo '☸️  Deploying to Kubernetes...'
        sh 'kubectl apply -f k8s/dev-deployment.yaml'
      }
    }
  }
}
