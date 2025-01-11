# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "my-test-vpc"
    Environment = var.environment
  }
}

# Internet Gatway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main

  tags = {
    Name        = "my-test-vpc-igw"
    Environment = var.environment
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "my-test-vpc-public"
    Environment = var.environment
  }
}
