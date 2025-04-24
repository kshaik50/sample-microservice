pipeline {
  agent {
    docker {
      image 'node:18-alpine'     // ✅ Node.js & npm pre-installed
      args '-v /tmp:/tmp'        // Optional: volume if needed
    }
  }

  environment {
    REGISTRY = 'docker.io/kshaik50'
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
        withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh 'docker build -t $REGISTRY/$IMAGE_NAME:dev .'
          sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
          sh 'docker push $REGISTRY/$IMAGE_NAME:dev'
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f k8s/dev-deployment.yaml'
      }
    }
  }
}
