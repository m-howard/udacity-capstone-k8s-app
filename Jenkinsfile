pipeline {
  agent any

  environment {
    PROJECT = 'devops-capstone-app'
    DOCKER_NAMESPACE = 'mdhowar22'
    DOCKER_CREDENTIALS = 'dockerhub'
    STACK_NAME = 'CapstoneK8sCluster'
    CLUSTER_NAME = 'CapstoneK8sCluster'
  }

  stages {

    stage('Initialize') {
      steps {
        // sh "aws eks update-kubeconfig --name ${env.CLUSTER_NAME}"
        sh "echo TODO: Intialization stage"
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

        sh "docker build --target release -t ${env.PROJECT} ./app"

        script {
          docker.withRegistry('', DOCKER_CREDENTIALS) {
            def dockerImage = docker.image("${env.PROJECT}")
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

  post {
    always {
      sh "docker rmi ${env.PROJECT}"
      sh "docker rmi ${env.DOCKER_REGISTRY}"
    }
  }
}