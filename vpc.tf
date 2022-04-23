#Variables
variable "aws_access_key" {}
variable "aws_secret_key" {}

#AWS as Provider
provider "aws" {
  region = "us-east-2"
  access_key=var.aws_access_key
  secret_key=var.aws_secret_key
}

#VPC Resources
resource "aws_vpc" "calc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames="true"

  tags = {
    Name = "CALC-VPC"
  }
}

#PUBLIC SUBNET
resource "aws_subnet" "calc-pub" {
  vpc_id     = aws_vpc.calc.id
  cidr_block = "10.0.0.0/22"
  map_public_ip_on_launch="true"
  tags = {
    Name = "CALC-PUB-SN"
  }
}

#PRIVATE SUBNET
resource "aws_subnet" "hdfc-pvt" {
  vpc_id     = aws_vpc.calc.id
  cidr_block = "10.0.4.0/22"
  
  tags = {
    Name = "CALC-PVT-SN"
  }
}

#INTERNET GATEWAY
resource "aws_internet_gateway" "calc-igw" {
  vpc_id = "${aws_vpc.calc.id}"

  tags = {
    Name = "CALC-IGW"
  }
}

#PUBLIC ROUTE TABLE
resource "aws_route_table" "calc-pub-rt" {
  vpc_id = aws_vpc.calc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.calc-igw.id
  }

  tags = {
    Name = "CALC-PUB-RT"
  }
}

#PRIVATE ROUTE TABLE
resource "aws_route_table" "calc-pvt-rt" {
  vpc_id = aws_vpc.calc.id

  tags = {
    Name = "CALC-PVT-RT"
  }
}

#PUBLIC ASSOCIATION
resource "aws_route_table_association" "calc-pub-asc" {
  subnet_id      = aws_subnet.calc-pub.id
  route_table_id = aws_route_table.calc-pub-rt.id
}

#PRIVATE ASSOCIATION
resource "aws_route_table_association" "calc-pvt-asc" {
  subnet_id      = aws_subnet.calc-pvt.id
  route_table_id = aws_route_table.calc-pvt-rt.id
}
