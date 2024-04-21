provider "aws" {
  region = "us-east-1"
}

module "vpc-staging" {
  source = "../../Modules/aws_network"
  env = "staging"
}