pipeline {
    agent any

    parameters {
        choice(
            name: 'ENV',
            choices: ['dev', 'uat', 'prod'],
            description: 'Select Environment'
        )
    }

    stages {

        stage('Git Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Version') {
            steps {
                sh 'terraform version'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh "terraform plan -var-file=env/${ENV}.tfvars"
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Approve Terraform Apply for ${ENV}?"
                sh "terraform apply -auto-approve -var-file=env/${ENV}.tfvars"
            }
        }
    }

    post {
        success {
            echo "Terraform deployment completed successfully!"
        }

        failure {
            echo "Terraform deployment failed!"
        }
    }
}
