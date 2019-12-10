pipeline {
  agent any

  environment {
    PROJECT = 'devops-capstone-app'
    DOCKER_CREDENTIALS = credentials('dockerhub')
    STACK_NAME = 'CapstoneK8sCluster'
    CLUSTER_NAME = 'CapstoneK8sCluster'
    STACK_S3_BUCKET = "markus-udacity-capstone-k8s-app"
  }

  stages {

    stage('Initialize') {
      steps {
        sh """
          aws eks update-kubeconfig --name ${env.CLUSTER_NAME}
          kubectl get svc
        """
      }
    }

    stage('Build') {
      steps {
        sh "docker build --target dependencies -t ${env.PROJECT} ./app"
      }
    }

    stage('Validate') {
      steps {
        sh "bash ./scripts/validate-cf-templates.sh infra"
        sh "docker build --target test -t ${env.PROJECT} ./app"
        sh "docker run --rm -i hadolint/hadolint < ./app/Dockerfile"
      }
    }

    stage('Publish Artifacts') {
      steps {
        sh "echo 'publishing image artifact'"

        sh """
          docker build --target release -t ${DOCKER_CREDENTIALS_USR}/${env.PROJECT} ./app
          docker tag ${env.PROJECT} ${DOCKER_CREDENTIALS_USR}/${env.PROJECT}:${BUILD_NUMBER}
        """

        sh """
          echo ${DOCKER_CREDENTIALS_PSW} | docker login --username ${DOCKER_CREDENTIALS_USR} --password-stdin
          docker push ${DOCKER_CREDENTIALS_USR}/${env.PROJECT}:${BUILD_NUMBER}
          docker push ${DOCKER_CREDENTIALS_USR}/${env.PROJECT}:latest
        """

        sh """
          aws s3 sync infra s3://${STACK_S3_BUCKET}
        """
      }
    }

    stage('Sync Infrastructure') {
      steps {
        sh """
          bash ./scripts/sync-cf-stack.sh us-west-2 ${env.STACK_NAME} --template-url https://s3.amazonaws.com/${STACK_S3_BUCKET}/eks.yaml --parameters file://infra/params.json --capabilities CAPABILITY_NAMED_IAM
        """
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
      sh """
      docker rmi ${env.PROJECT}
      docker rmi ${DOCKER_CREDENTIALS_USR}/${env.PROJECT}:${BUILD_NUMBER}
      """
    }
  }
}