pipeline {
    agent any

    stages {
        stage('Git Pull') {
            steps {
                git 'your-github-repo-url'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'cd terraform && terraform init'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'cd terraform && terraform apply -auto-approve'
            }
        }
    }
}
