pipeline {
  agent any

  def stackName = 'UdacityCapstoneK8s'
  def clusterName = 'UdacityCapstoneCluster'
  def vpcId = 'vpc-077a8e9fa2d56af49'
  def subnets = 'subnet-0d30eafdcb6dd7196, subnet-06daf89c1c56df89d'
  def keyName = 'pipeline'

  stages {

    stage('Initialize') {
      sh "echo test ${stackName}"
    }

    stage('Build') {}

    stage('Validate') {}

    stage('Publish Artifact') {}

    stage('Security Scan') {}

    stage('Sync Infrastructure') {}

    stage('Deploy Service') {}

  }
}