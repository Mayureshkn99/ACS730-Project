provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
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

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_cidr_blocks)
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.public_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "Public-Subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_cidr_blocks)
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.private_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "Private-Subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_dev.id
  }
  tags = {
    Name = "route-public-subnets"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}