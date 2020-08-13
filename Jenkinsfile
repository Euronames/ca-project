pipeline {
  agent any
  stages {
    stage('clone_down') {
      steps {
        stash(excludes: '.git', name: 'code')
      }
    }

    stage('_create artifact_ and _dockerize application_') {
      parallel {
        stage('_create artifact_') {
          agent any
          
          options {
            skipDefaultCheckout(true)
          }
          steps {
              unstash 'code'
              sh 'tar czf - Application > archived.tar.gz'
              archiveArtifacts 'archived.tar.gz'
              stash(excludes: '.git', name: 'artifacts')
              deleteDir()
          }
        }

        stage('_dockerize application_') {
          
          when {
            branch 'master'
          }

          options {
            skipDefaultCheckout(true)
          }

          environment {
            DOCKERCREDS = credentials('docker_login') //use the credentials just created in this stage
          }

          steps {
           unstash 'code' //unstash the repository code
           sh 'ci/build-docker.sh'
           sh 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin' //login to docker hub with the credentials above
           sh 'ci/push-docker.sh'
          }
        }
        stage('Test') {
          agent {
            docker {
              image 'python:latest'
            }
          }

          options {
            skipDefaultCheckout(true)
          }

          steps {
            unstash 'code' //unstash the repository code
            sh 'ci/test.sh'
          }
        }
      }
    }
    stage ('Deploy') {
        steps{
            sshagent (credentials: ['ubuntu']){
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@35.187.0.187 ./ca-project/ci/run.sh'}
        }
    }
  }
  environment {
    docker_username = 'euronames'
  }
}