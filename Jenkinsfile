pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
        SSH_KEY = '/root/jenkins-slave/.ssh/newkey.pem'
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
        -i ${SSH_KEY} \
        ubuntu@${EC2_IP} << 'EOF'

        set -e

                echo "Installing Docker..."

        sudo apt update -y
        sudo apt install -y docker.io

        sudo systemctl start docker
        sudo systemctl enable docker

        sudo usermod -aG docker ubuntu

        cd /home/ubuntu

        if [ ! -d hospital-management-project ]; then
            git clone https://github.com/sumitd-555/hospital-management-project.git
        fi

        cd hospital-management-project/frontend

        echo "Stopping old container..."

        sudo docker stop hospital-app || true
        sudo docker rm hospital-app || true

        echo "Building Docker image..."

        sudo docker build -t hospital-app .

        echo "Running new container..."

        sudo docker run -d \
            --name hospital-app \
            -p 80:80 \
            hospital-app

        echo "Deployment completed successfully"

        }
      }
     } 
        EOF
        """

    post {
        success {
            echo "🚀 Deployment Successful - Website LIVE at http://${EC2_IP}"
        }

        failure {
            echo "❌ Deployment Failed"
        }
    }
}
}
