pipeline {
  agent {
    node {
        label 'Agent-01'
    }
  }
  
  stages {
    stage('Clone Repository') {
      steps {
        checkout([$class: 'GitSCM',
                  branches: [[name: '*/main']],
                  userRemoteConfigs: [[
                    url: 'git@github.com:ojotosin/expressjapa-jenkins.git',
                    credentialsId: 'github-jenkins-ssh-key'
                  ]]
                ])
      }
    }
    
    //triggers {
    //    pollSCM('*/5 * * * *')
    //}


    stage('Build Docker Image') {
      steps {
        dir ('docker') {
            sh 'sudo chmod +x build_image-v2.sh'
            sh 'sudo ./build_image-v2.sh'
        }
      }
    }
    
    stage('Push Image to ECR') {
      environment {
        AWS_DEFAULT_REGION = 'us-east-1'
      }
      
      steps {
          script {
              sh 'aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | sudo docker login --username AWS --password-stdin 774443160673.dkr.ecr.us-east-1.amazonaws.com'
              sh 'sudo docker tag expressjapa:latest 774443160673.dkr.ecr.us-east-1.amazonaws.com/expressjapa:latest'
              sh 'sudo docker push 774443160673.dkr.ecr.us-east-1.amazonaws.com/expressjapa:latest'
          }
      }
    }
    
    stage('Deploy') {
      environment {
        AWS_DEFAULT_REGION = 'us-east-1'
      }
      
      steps {
        withCredentials([string(credentialsId: 'aws-jenkins', variable: 'AWS_ACCESS_KEY_ID'),
                         string(credentialsId: 'aws-jenkins', variable: 'AWS_SECRET_ACCESS_KEY')]) {
          dir('terraform-web-infrastructure') {
            sh 'terraform init'
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }
  }
}
