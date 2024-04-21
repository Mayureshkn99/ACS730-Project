provider "aws" {
  region = "us-east-1"
}

module "vpc-dev" {
  source = "../../Modules/aws_network"
  env = "dev"
}