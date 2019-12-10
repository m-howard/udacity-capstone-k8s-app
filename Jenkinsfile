pipeline {
  agent any

  environment {
    STACK_NAME = 'UdacityCapstoneK8s'
  }

  stages {

    stage('Initialize') {
      steps {
        sh "echo test ${env.STACK_NAME}"
      }
    }

    stage('Build') {
      steps {
        sh "echo 'building docker'"
      }
    }

    stage('Validate') {
      steps {
        sh "echo 'validating'"
      }
    }

    stage('Publish Artifact') {
      steps {
        sh "echo 'publishing image artifact'"
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