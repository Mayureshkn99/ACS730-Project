provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "dev_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "VPC Prod"
  }
}

resource "aws_internet_gateway" "igw_dev" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    "Name" = "igw"
  }
}