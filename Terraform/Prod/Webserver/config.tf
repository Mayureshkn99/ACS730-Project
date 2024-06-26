terraform {
  backend "s3" {
    bucket = "prod-group5-s3"                // Bucket from where to GET Terraform State
    key    = "webservers/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                    // Region where bucket created
  }
}