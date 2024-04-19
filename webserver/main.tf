# Terraform Config file (main.tf). This has provider block (AWS) and config for provisioning
# EC2 instance resources and a Bastion VM.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.27"
    }
  }

  required_version = ">=0.14"
}
provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "networking" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "dev-group5-s3"         // Bucket from where to GET Terraform State
    key    = "Network/terraform.tfstate"
    region = "us-east-1" // Region where bucket created
  }
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Define tags locally
locals {
  default_tags = var.default_tags
  name_prefix  = var.prefix

}

# Provisioning the private webserver VMs
resource "aws_instance" "private_webservers" {
  count                       = length(data.terraform_remote_state.networking.outputs.private_subnet_id)
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_keypair.key_name
  security_groups             = [aws_security_group.private_webservers_sg.id]
  subnet_id                   = data.terraform_remote_state.networking.outputs.private_subnet_id[count.index]
  associate_public_ip_address = false

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-private-webserver-${count.index + 1}"
    }
  )
}

# Provisioning the public webserver VMs
resource "aws_instance" "public_webservers" {
  count                       = length(data.terraform_remote_state.networking.outputs.public_subnet_id)
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_keypair.key_name
  security_groups             = [aws_security_group.public_webservers_sg.id]
  subnet_id                   = data.terraform_remote_state.networking.outputs.public_subnet_id[count.index]
  associate_public_ip_address = true
  user_data = count.index < 2 ? templatefile("install_httpd.sh",
    {
      prefix = upper(var.prefix)
    }
  ) : null

  tags = merge(local.default_tags,
    {
      "Name" = "${var.prefix}-public-webserver-${count.index + 1}"
    }
  )
}

# Adding SSH key to be used by EC2 instance
resource "aws_key_pair" "ssh_keypair" {
  key_name   = "keypair"
  public_key = file("projectkey.pub")
}