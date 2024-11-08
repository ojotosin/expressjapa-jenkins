
pipeline {
    agent {
    node {
        label 'Agent-01'
    }
  }
    
    stages {
        stage('Run Cleanup Script') {
            steps {
                sh './cleanup.sh'
            }
        }
    }
    post {
        success {
            echo 'Cleanup completed successfully.'
        }
        failure {
            echo 'Cleanup failed.'
        }
    }
}
