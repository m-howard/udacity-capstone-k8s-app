pipeline {
  agent any

  environment {
    STACK_NAME = 'UdacityCapstoneK8s'
  }

  stages {

    stage('Initialize') {
      sh "echo test ${env.STACK_NAME}"
    }

    stage('Build') {
      sh "echo 'building docker'"
    }

    stage('Validate') {
      sh "echo 'validating'"
    }

    stage('Publish Artifact') {
      sh "echo 'publishing image artifact'"
    }

    stage('Security Scan') {
      sh "echo 'running security scan'"
    }

    stage('Sync Infrastructure') {
      sh "echo 'syncing infrastructure'"
    }

    stage('Deploy Service') {
      sh "echo 'deploying service'"
    }

  }
}