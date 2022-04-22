#Variables
variable "aws_access_key" {}
variable "aws_secret_key" {}

#AWS as Provider
provider "aws" {
  region = "us-east-1"
  access_key=var.aws_access_key
  secret_key=var.aws_secret_key
}

#ANSIBLE MASTER
resource "aws_instance" "ansible-master" {

  ami           = "ami-region-dummy"
  instance_type = "t2.micro"
  user_data=file("installansible.sh")
  subnet_id=aws_subnet.hdfc-pub.id
  private_ip="172.31.16.20"
  vpc_security_group_ids=[aws_security_group.hdfc-web-sg.id]
  key_name="Hola"
  
  tags = {
    Name = "MasterBox"
  }
}

#ANSIBLE NODE-1
resource "aws_instance" "node1" {

  ami           = "ami-region-dummy"
  instance_type = "t2.micro"
  
  subnet_id=aws_subnet.hdfc-pub.id
  private_ip="172.31.16.21"
  vpc_security_group_ids=[aws_security_group.hdfc-web-sg.id]
  key_name="Hola"
  
  tags = {
    Name = "Node1"
  }
}

#ANSIBLE NODE-2
resource "aws_instance" "node2" {

  ami           = "ami-region-dummy"
  instance_type = "t2.micro"
  
  subnet_id=aws_subnet.hdfc-pub.id
  private_ip="172.31.16.22"
  vpc_security_group_ids=[aws_security_group.hdfc-web-sg.id]
  key_name="Hola"
  
  tags = {
    Name = "Node2"
  }
}
