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

       stage('Deploy using Docker') {
    steps {
        sh """
        ssh -o StrictHostKeyChecking=no \
        -i /root/jenkins-slave/.ssh/hospital-key \
        ec2-user@${EC2_IP} << 'EOF'

        set -e

        echo "Installing Docker..."
        sudo yum update -y
        sudo yum install -y docker

        sudo service docker start
        sudo systemctl enable docker

        sudo usermod -a -G docker ec2-user || true

        echo "Installing Git..."
        sudo yum install -y git

        echo "Installing Docker Compose..."
        sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-\$(uname -s)-\$(uname -m)" \
        -o /usr/local/bin/docker-compose

        sudo chmod +x /usr/local/bin/docker-compose

        echo "Cloning repo..."
        rm -rf hospital-management-project
        git clone https://github.com/sumitd-555/hospital-management-project.git

        cd hospital-management-project

        echo "Running containers..."
        sudo docker-compose down || true
        sudo docker-compose up -d --build

        EOF
        """
    }
}
}
