pipeline {
  agent any

  environment {
    PROJECT = 'devops-capstone-app'
    DOCKER_REGISTRY = 'mdhowar22/${env.PROJECT}'
    DOCKER_CREDENTIALS = 'dockerhub'
    STACK_NAME = 'CapstoneK8sCluster'
  }

  stages {

    stage('Initialize') {
      steps {
        // sh 'aws eks update-kubeconfig --name ${env.PROJECT}'
        sh 'echo Will initialize kubeconfig'
      }
    }

    stage('Build') {
      steps {
        sh "docker build --target dependencies -t ${env.PROJECT} ./app"
      }
    }

    stage('Validate') {
      steps {
        sh "docker build --target test -t ${env.PROJECT} ./app"
        sh "docker run --rm -i hadolint/hadolint < ./app/Dockerfile"
      }
    }

    stage('Publish Artifact') {
      steps {
        sh "echo 'publishing image artifact'"

        script {
          dockerImage = docker.build("${env.DOCKER_REGISTRY}", "./app")
          docker.withRegistry('', DOCKER_CREDENTIALS) {
            dockerImage.push("${BUILD_NUMBER}")
            dockerImage.push('latest')
          }
        }
      }
    }

    stage('Security Scan') {
      steps {
        sh "echo 'running security scan'"
      }
    }

    stage('Sync Infrastructure') {
      steps {
        sh "echo 'syncing infrastructure'"
      }
    }

    stage('Deploy Service') {
      steps {
        sh "echo 'deploying service'"
      }
    }

  }
}