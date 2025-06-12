terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
    region = var.aws_region
}



data "aws_vpc" "default" {
    default = true
}


# Security Group setup
resource "aws_security_group" "minecraft" {
    name = "minecraft"
    description = "Minecraft server setup for Part 2"
    vpc_id = data.aws_vpc.default.id

    
    # Setting up the SSH port of 22 from any IPv4
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Setting up the minecraft port of 25565 from any IPv4
    ingress {
        from_port = 25565
        to_port = 25565
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


# Setting up the valid key pair
resource "aws_key_pair" "minecraft_key" {
    key_name = "minecraft_key"
    public_key = file("~/.ssh/id_rsa.pub")
}


# Selecting machine image from amazon (AMI)
data "aws_ami" "al2" {

    # Most recent from Amazon
    most_recent = true
    owners = ["amazon"]
    
    # Find the image
    values =

    }
}


resource "aws_instance" "minecraft2" {
    # Use the image we just defined
    ami = data.aws_ami.al2.id

    # Get instance from var.tf file (t2.micro)
    instance_type = var.instance

    # Use key pair we just defined
    key_name = aws_key_pair.minecraft_key.key_name

    # Use security group we just defined
    vpc_security_group_ids = [aws_security_group.minecraft.id]
    
    # Set instance name
    tags = {Name = "minecraft_server2"}
}
