terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

#security group
resource "aws_security_group" "minecraft-server" {
  name        = "cs312-minecraft-server-sg"
  description = "For admin and server clients"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "minecraft server clients"
    from_port   = 25565
    to_port     = 25565
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
    Name = "cs312-minecraft-server-sg"
  }
}

resource "aws_instance" "minecraft-server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.minecraft-server.id]
  associate_public_ip_address = true
  iam_instance_profile   = "LabInstanceProfile"

   root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "cs312-minecraft-op3"
  }
}

# ECR repository
resource "aws_ecr_repository" "minecraft-server" {
  name                 = "cs312-minecraft-op3"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
