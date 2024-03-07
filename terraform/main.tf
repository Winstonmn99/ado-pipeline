provider "aws" {
  region = var.location
}

resource "aws_vpc" "volvo-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "volvo-vpc"
  }
}


resource "aws_subnet" "volvo-pub-subnet" {
  vpc_id                  = aws_vpc.volvo-vpc.id
  cidr_block              = var.subnet-cidr
  availability_zone       = var.subent-az
  map_public_ip_on_launch = "true"
  tags = {
    Name = "volvo-sub"
  }
}


resource "aws_internet_gateway" "volvo_igw" {
  vpc_id = aws_vpc.volvo-vpc.id
  tags = {
    Name = "volvo-IGW"
  }
}



resource "aws_route_table" "volvo_route_table" {
  vpc_id = aws_vpc.volvo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.volvo_igw.id
  }
  tags = {
    Name = "volvo-route-table"
  }
}


resource "aws_route_table_association" "volvo_route_table_association" {
  subnet_id      = aws_subnet.volvo-pub-subnet.id
  route_table_id = aws_route_table.volvo_route_table.id
}



resource "aws_security_group" "volvo_security_group" {
  vpc_id = aws_vpc.volvo-vpc.id


  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "volvo-SG"
  }
}


resource "aws_instance" "volvo_instance" {
  ami                         = var.ami-id
  instance_type               = var.instance-type
  subnet_id                   = aws_subnet.volvo-pub-subnet.id
  security_groups             = [aws_security_group.volvo_security_group.id]
  associate_public_ip_address = true
  key_name                    = var.key

  user_data = <<-EOL
  #!/bin/bash -xe
  sudo apt update
  sudo apt -y install docker.io
  sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  sudo chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo chmod +x minikube
  sudo mv minikube /usr/local/bin/
  sudo apt -y install conntrack
  sudo usermod -aG docker $USER
  newgrp docker
  minikube start
  exit
  EOL

  tags = {
    Name = "volvo-ec2"
  }
}

output "public_ip_of_volvo_server" {
  description = "this is the public IP"
  value       = aws_instance.volvo_instance.public_ip
}

output "private_ip_of_volvo_server" {
  description = "this is the public IP"
  value       = aws_instance.volvo_instance.private_ip
}
