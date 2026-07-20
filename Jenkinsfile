pipeline {
    agent any

    parameters {

        choice(
            name: 'ENV',
            choices: ['dev', 'uat', 'prod'],
            description: 'Select Environment'
        )

        choice(
            name: 'ACTION',
            choices: ['plan', 'apply', 'destroy'],
            description: 'Select Terraform Action'
        )

        string(
            name: 'BRANCH',
            defaultValue: 'feature/jenkins-setup',
            description: 'Git Branch'
        )
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scmGit(
                    branches: [[name: "*/${params.BRANCH}"]],
                    userRemoteConfigs: [[url: 'https://github.com/ajayM1988/terraform-jenkins-project.git']]
                )
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

        stage('Terraform Action') {
            steps {
                script {

                    def tfvarsFile = "env/${params.ENV}.tfvars"

                    if (params.ACTION == 'plan') {

                        echo "Running PLAN for ${params.ENV}"

                        sh "terraform plan -var-file=${tfvarsFile}"

                    } else if (params.ACTION == 'apply') {

                        echo "Running APPLY for ${params.ENV}"

                        sh "terraform apply -auto-approve -var-file=${tfvarsFile}"

                    } else if (params.ACTION == 'destroy') {

                        echo "Running DESTROY for ${params.ENV}"

                        sh "terraform destroy -auto-approve -var-file=${tfvarsFile}"
                    }
                }
            }
        }
    }

    post {

        success {
            echo 'Terraform execution completed successfully!'
        }

        failure {
            echo 'Terraform execution failed!'
        }
    }
}