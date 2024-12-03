terraform {
  backend "s3" {
    bucket = ""
    key    = "week7/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = ""
    encrypt = true
  }
}