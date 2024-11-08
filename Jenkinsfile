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

    // Uncomment to enable SCM polling
    // triggers {
    //   pollSCM('*/5 * * * *')
    // }

    stage('Build Docker Image') {
      steps {
        dir('docker') {
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
        withCredentials([usernamePassword(credentialsId: 'jenkins-terraform-user', 
                                          usernameVariable: 'AWS_ACCESS_KEY_ID', 
                                          passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          script {
            // Configure AWS CLI with the credentials
            sh '''
              aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
              aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
              aws configure set region ${AWS_DEFAULT_REGION}
            '''
            
            // Login to ECR and push the Docker image
            sh 'aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | sudo docker login --username AWS --password-stdin 774443160673.dkr.ecr.us-east-1.amazonaws.com'
            sh 'sudo docker tag expressjapa-v1:latest 774443160673.dkr.ecr.us-east-1.amazonaws.com/expressjapa:latest'
            sh 'sudo docker push 774443160673.dkr.ecr.us-east-1.amazonaws.com/expressjapa:latest'
          }
        }
      }
    }

    stage('Deploy') {
      environment {
        AWS_DEFAULT_REGION = 'us-east-1'
      }
      
      steps {
        dir('terraform-web-infrastructure') {
          sh 'terraform init'
          sh 'terraform apply -auto-approve'
        }
      }
    }
  }
}
