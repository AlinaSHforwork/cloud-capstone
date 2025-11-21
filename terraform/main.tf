terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Change if you configured a different region in aws configure
}

# 1. Create a Key Pair in AWS using your local public key
resource "aws_key_pair" "deployer" {
  key_name   = "capstone-key"
  public_key = file("~/.ssh/capstone_key.pub")
}

# 2. Create a Security Group (Firewall)
resource "aws_security_group" "allow_web" {
  name        = "capstone-security-group"
  description = "Allow SSH and Web traffic"

  # Allow SSH (Port 22)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: Open to the world. In production, restrict to your IP.
  }

  # Allow Flask App (Port 5000)
  ingress {
    description = "Flask API"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic (so the server can download updates)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. Find the latest Ubuntu 22.04 AMI (Amazon Machine Image)
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical (Official Ubuntu Owner ID)
}

# 4. Create the EC2 Instance
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  security_groups = [aws_security_group.allow_web.name]

  tags = {
    Name = "Capstone-Server"
  }
}

# 5. Output the Public IP (We need this for Ansible later!)
output "instance_public_ip" {
  description = "The public IP of the web server"
  value       = aws_instance.web_server.public_ip
}