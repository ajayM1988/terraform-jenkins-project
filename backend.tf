terraform {
  backend "s3" {
    bucket         = "ajay-tf-state-2026"
    key            = "jenkins/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
####################