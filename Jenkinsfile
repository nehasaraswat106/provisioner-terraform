pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key')    // AWS Access Key from Jenkins credentials
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key') // AWS Secret Key from Jenkins credentials
        AWS_REGION = 'us-east-1'                             // Specify your AWS region
        TERRAFORM_DIR = 'terraform'                          // Path to your Terraform configuration
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Initialize Terraform') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    echo 'Initializing Terraform...'
                    bat '''
                        terraform init
                    '''
                }
            }
        }

        stage('Validate Terraform') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    echo 'Validating Terraform configuration...'
                    bat '''
                        terraform validate
                    '''
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    echo 'Planning Terraform execution...'
                    bat '''
                        terraform plan -var="aws_access_key=%AWS_ACCESS_KEY_ID%" -var="aws_secret_key=%AWS_SECRET_ACCESS_KEY%" -var="region=%AWS_REGION%"
                    '''
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    echo 'Applying Terraform configuration...'
                    bat '''
                        terraform apply -auto-approve -var="aws_access_key=%AWS_ACCESS_KEY_ID%" -var="aws_secret_key=%AWS_SECRET_ACCESS_KEY%" -var="region=%AWS_REGION%"
                    '''
                }
            }
        }

        stage('Post-Provisioning') {
            steps {
                echo 'Post-provisioning tasks (if