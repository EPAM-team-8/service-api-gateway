pipeline {
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    
    agent any
    tools {
        terraform 'Terraform-11'
        maven 'maven3'
    }

    stages {

        stage('Build Application') { 
            steps {
                sh 'mvn clean package' 
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform'){
                sh ('terraform init')
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                dir('terraform'){
                sh ('terraform plan')
                }
            }
        }
        
        stage('Terraform Apply') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'epamkey',keyFileVariable: 'SSH_KEY')]) {
                sh 'cp "$SSH_KEY" ./awskey.pem'
                dir('terraform'){
                sh ('terraform apply -auto-approve')
                }
                }
            }
        }
    }
}
