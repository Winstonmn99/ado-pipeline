provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "volvo-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "volvo-vpc"
  }
}


resource "aws_subnet" "volvo-pub-subnet" {
  vpc_id            = aws_vpc.volvo-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
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
  ami             = "ami-0c7217cdde317cfec"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.volvo-pub-subnet.id
  security_groups = [aws_security_group.volvo_security_group.id]
  associate_public_ip_address = true
  key_name        = "volvo-key"
  
    tags = {
    Name = "volvo-ec2"
  }
}
