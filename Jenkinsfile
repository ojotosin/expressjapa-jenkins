pipeline {
    agent {
        label 'Agent-01'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-jenkins-ssh-key',
                    url: 'git@github.com:ojotosin/expressjapa-jenkins.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip install checkov'
                // Install any other necessary dependencies or tools
            }
        }

        stage('Validate Terraform Code') {
            steps {
                sh 'terraform init'
                sh 'terraform validate'
                // Add any additional validation steps as needed
            }
        }

        stage('Scan for Vulnerabilities') {
            steps {
                sh 'find . -type f -name "*.tf" -exec checkov -f {} \\;'
                // Run other vulnerability scanning tools if needed
                // Capture the scan results and generate reports or outputs
            }
        }




    }
}
