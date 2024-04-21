terraform {
  backend "s3" {
    bucket = "dev-group5-s3"
    key    = "Network/terraform.tfstate"
    region = "us-east-1"
  }
}