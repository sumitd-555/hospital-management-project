pipeline {
    agent {
        label 'jenkins-slave'
    }

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/sumitd-555/hospital-management-project.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy Application to Apache') {
            steps {
                sh '''
                    echo "Deploying project to /var/www/html..."

                    sudo mkdir -p /var/www/html

                    sudo rm -rf /var/www/html/*

                    sudo cp -r frontend/* /var/www/html/
                    sudo cp -r backend/* /var/www/html/

                    sudo chown -R apache:apache /var/www/html/
                    sudo chmod -R 755 /var/www/html/

                    sudo systemctl restart httpd
                    sudo systemctl status httpd
                '''
            }
        }
    }

    post {
        success {
            echo 'Infrastructure + Application deployed successfully!'
        }

        failure {
            echo 'Pipeline failed. Please check logs.'
        }
    }
}
