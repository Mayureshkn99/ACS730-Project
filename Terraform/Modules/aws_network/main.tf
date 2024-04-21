provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "VPC ${var.env}"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    "Name" = "igw-${var.env}"
  }
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_cidr_blocks)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "${var.env}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_cidr_blocks)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "${var.env}-private-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    Name = "${var.env}-route-public-subnets"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.env}-nat-gw"
  }
}

resource "aws_route_table" "nat_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.env}-route-nat-gw"
  }
}

resource "aws_route_table_association" "nat_routes" {
  subnet_id      = aws_subnet.private_subnets[0].id
  route_table_id = aws_route_table.nat_rt.id
}