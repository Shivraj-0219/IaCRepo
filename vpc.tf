#Variables
variable "aws_access_key" {}
variable "aws_secret_key" {}

#AWS as Provider
provider "aws" {
  region = "us-east-1"
  access_key=var.aws_access_key
  secret_key=var.aws_secret_key
}

#VPC Resources
resource "aws_vpc" "hdfc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames="true"

  tags = {
    Name = "HDFC-VPC"
  }
}

#PUBLIC SUBNET
resource "aws_subnet" "hdfc-pub" {
  vpc_id     = aws_vpc.hdfc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch="true"
  tags = {
    Name = "HDFC-PUB-SN"
  }
}

#PRIVATE SUBNET
resource "aws_subnet" "hdfc-pvt" {
  vpc_id     = aws_vpc.hdfc.id
  cidr_block = "10.0.1.0/24"
  
  tags = {
    Name = "HDFC-PVT-SN"
  }
}

#INTERNET GATEWAY
resource "aws_internet_gateway" "hdfc-igw" {
  vpc_id = "${aws_vpc.hdfc.id}"

  tags = {
    Name = "HDFC-IGW"
  }
}

#PUBLIC ROUTE TABLE
resource "aws_route_table" "hdfc-pub-rt" {
  vpc_id = aws_vpc.hdfc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hdfc-igw.id
  }

  tags = {
    Name = "HDFC-PUB-RT"
  }
}

#PRIVATE ROUTE TABLE
resource "aws_route_table" "hdfc-pvt-rt" {
  vpc_id = aws_vpc.hdfc.id

  tags = {
    Name = "HDFC-PVT-RT"
  }
}

#PUBLIC ASSOCIATION
resource "aws_route_table_association" "pdfc-pub-asc" {
  subnet_id      = aws_subnet.hdfc-pub.id
  route_table_id = aws_route_table.hdfc-pub-rt.id
}

#PRIVATE ASSOCIATION
resource "aws_route_table_association" "pdfc-pvt-asc" {
  subnet_id      = aws_subnet.hdfc-pvt.id
  route_table_id = aws_route_table.hdfc-pvt-rt.id
}