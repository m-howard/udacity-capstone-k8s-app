pipeline {
  agent any

  environment {
    STACK_NAME = 'UdacityCapstoneK8s'
  }

  stages {

    stage('Initialize') {
      sh "echo test ${env.STACK_NAME}"
    }

    stage('Build') {}

    stage('Validate') {}

    stage('Publish Artifact') {}

    stage('Security Scan') {}

    stage('Sync Infrastructure') {}

    stage('Deploy Service') {}

  }
}