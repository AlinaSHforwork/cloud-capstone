provider "aws" {
  region = "us-east-1"
}

# Security Group to allow SSH and HTTP
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP and SSH"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # In real life, restrict this to your IP
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# The Web Server
resource "aws_instance" "web_server" {
  ami             = "ami-0c7217cdde317cfec" # Ubuntu 22.04 (verify ID for your region)
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "Capstone-WebServer"
  }
}

# Output the Public IP so Ansible knows where to go
output "web_instance_ip" {
  value = aws_instance.web_server.public_ip
}