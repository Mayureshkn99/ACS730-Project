provider "aws" {
  region = "us-east-1"
}

module "webserver-prod" {
  source = "../../Modules/aws_webserver"
  env = "prod"
}