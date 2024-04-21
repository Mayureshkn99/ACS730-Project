provider "aws" {
  region = "us-east-1"
}

module "webserver-dev" {
  source = "../../Modules/aws_webserver"
  env = "dev"
}