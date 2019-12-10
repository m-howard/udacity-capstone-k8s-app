pipeline {
  agent any

  environment {
    PROJECT = 'devops-capstone-app'
    DOCKER_CREDENTIALS = credentials('dockerhub')
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

        sh "docker build --target release -t ${DOCKER_CREDENTIALS_USR}/${env.PROJECT} ./app"

        sh "docker tag ${env.PROJECT} ${DOCKER_CREDENTIALS_USR}/${env.PROJECT}:${BUILD_NUMBER}"

        sh """
          echo ${DOCKER_CREDENTIALS_PSW} | docker login --username ${DOCKER_CREDENTIALS_USR} --password-stdin
          docker push ${DOCKER_CREDENTIALS_USR}/${env.PROJECT}:${BUILD_NUMBER}
          docker push ${DOCKER_CREDENTIALS_USR}/${env.PROJECT}:latest
        """
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
      sh "docker rmi ${DOCKER_NAMESPACE}/${env.PROJECT}"
    }
  }
}