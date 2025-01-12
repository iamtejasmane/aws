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
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "my-test-vpc-igw"
    Environment = var.environment
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "my-test-vpc-public"
    Environment = var.environment
  }
}

# Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "aws-test-vpc-public-rt"
    Environment = var.environment
  }
}

# Route table association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "ec2" {
  name        = "ec2-security-group"
  description = "Security group for EC2 instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH for my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ec2-security-group"
    Environment = var.environment
  }
}


# # Data source to get Amazon Linux 2 AMI
# data "aws_ami" "amazon_linux_2" {
#   most_recent = true
#   owners = [ "amazon" ]

#   filter {
#     name = "name"
#     values = "amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"
#   }

#   filter {
#     name = "virtualization-type"
#     values = [ "hvm" ]
#   }

#   filter {
#     name = "root-device-type"
#     values = [ "ebs" ]
#   }
# }


# EC2 Instance
resource "aws_instance" "main" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.public.id
  key_name = var.key_name

  vpc_security_group_ids = [ aws_security_group.ec2.id ]

  tags = {
    Name = "my-test-instance"
    Environment = var.environment
  }

}
