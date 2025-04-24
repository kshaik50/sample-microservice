pipeline {
  agent any
  environment {
    REGISTRY = 'docker.io/yourdockerhub'
    IMAGE_NAME = 'react-frontend'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', credentialsId: 'github-creds', url: 'https://github.com/your-user/your-repo.git'
      }
    }

    stage('Build & Test') {
      steps {
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
