pipeline {
  agent any
  stages {
    stage('clone_down') {
      options {
        skipDefaultCheckout(true)
      }
      steps {
        stash(excludes: '.git', name: 'code')
      }
    }

    stage('_create artifact_ and _dockerize application_') {
      parallel { 

      stage('_create artifact_'){
      options {
        skipDefaultCheckout(true)
      }
      steps{
        sh 'echo "_create artifact_"'
      }
      }

      stage('_dockerize application_'){
      options {
        skipDefaultCheckout(true)
      }
      steps{
        sh 'echo "_dockerize application_"'
      }
      }
      }
    }
  }
  environment {
    docker_username = 'euronames'
  }
}