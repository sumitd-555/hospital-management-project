pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/sumitd-555/hospital-management-project.git'
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Get EC2 IP') {
            steps {
                script {
                    env.EC2_IP = sh(
                        script: "cd terraform && terraform output -raw public_ip",
                        returnStdout: true
                    ).trim()
                }
            }
        }

       stage('Deploy using Docker') {
    steps {
        sh """
        ssh -o StrictHostKeyChecking=no \
        -i /root/jenkins-slave/.ssh/hospital-key \
        ec2-user@${EC2_IP} << 'EOF'

                sudo yum update -y

                # Install Docker (if not installed)
                sudo yum install -y docker
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo usermod -aG docker ec2-user

                # Clone repo on server
                rm -rf hospital-management-project
                git clone https://github.com/sumitd-555/hospital-management-project.git

                cd hospital-management-project

                # Build and run containers
                sudo docker-compose down || true
                sudo docker-compose up -d --build

                EOF
                """
            }
        }
    }

    post {
        success {
            echo "🚀 Docker-based website is LIVE!"
        }

        failure {
            echo "❌ Deployment failed"
        }
    }
}
