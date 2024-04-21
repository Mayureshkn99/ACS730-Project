provider "aws" {
  region = "us-east-1"
}

module "vpc-prod" {
  source = "../../Modules/aws_network"
  env = "prod"
}