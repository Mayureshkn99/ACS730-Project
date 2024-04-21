provider "aws" {
  region = "us-east-1"
}

module "webserver-staging" {
  source = "../../Modules/aws_webserver"
  env = "staging"
}