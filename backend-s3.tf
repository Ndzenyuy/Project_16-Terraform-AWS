terraform {
  backend "s3" {
    bucket = "terra-aws-backend"
    key    = "terraform/backend"
    region = "us-east-2"
  }
}