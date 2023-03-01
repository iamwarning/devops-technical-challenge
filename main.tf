# Default VPC o personalizada
resource "aws_default_vpc" "default" {}

data "aws_elb_service_account" "this" {}
locals {
  userdata = templatefile("configuration.sh", {
    ssm_cloudwatch_config = aws_ssm_parameter.cw_agent.name
  })
}

# Instancia EC2 con Nginx
resource "aws_instance" "nginx_instance" {
  ami                  = "ami-0557a15b87f6559cf"
  instance_type        = "t2.micro"
  key_name             = "devops-pulpo"
  security_groups      = [aws_security_group.nginx_sg.name]
  availability_zone    = "us-east-1a"
  user_data            = local.userdata
  iam_instance_profile = aws_iam_instance_profile.this.name
  tags                 = {
    Name    = "Nginx Instance"
    Project = var.project_name
  }
}

# Crear grupo de seguridad para EC2
resource "aws_security_group" "nginx_sg" {
  name_prefix = "nginx-sg"
  description = "Allow SSH on PORT 22 & HTTP on port 8080"
  vpc_id      = aws_default_vpc.default.id

  #SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [
    aws_default_vpc.default,
  ]
}



