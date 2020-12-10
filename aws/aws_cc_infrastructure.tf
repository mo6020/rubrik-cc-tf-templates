# This is 100% unofficial and not supported by Rubrik.
# Set variables and tags to whatever you need.
# The AMI info will need to be shared with your account
# or you could just deploy from the market place...

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

# Get AMI info
data "aws_ami" "rubrik_cloud_cluster" {
  most_recent = true

  owners = ["447546863256"] # Rubrik

  filter {
    name   = "name"
    values = ["rubrik-*"]
  }
}

resource "aws_instance" "rubrik_cluster" {
  count                  = var.number_of_nodes
  instance_type          = var.aws_instance_type
  ami                    = data.aws_ami.rubrik_cloud_cluster.id
  vpc_security_group_ids = var.aws_vpc_security_group_ids
  subnet_id              = var.aws_subnet_id

  disable_api_termination = var.aws_disable_api_termination

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "st1"
    volume_size = var.cluster_disk_size
    encrypted   = true
  }

  ebs_block_device {
    device_name = "/dev/sdc"
    volume_type = "st1"
    volume_size = var.cluster_disk_size
    encrypted   = true
  }

  ebs_block_device {
    device_name = "/dev/sdd"
    volume_type = "st1"
    volume_size = var.cluster_disk_size
    encrypted   = true
  }

  tags = {
    Owner   = "ed"
    Project = "aws-cc-testing"
  }
}

