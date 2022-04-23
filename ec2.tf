#EC2 Resources
resource "aws_instance" "k8s-wrkstn" {

  ami           = "ami-0a5588cee1fe39fff"
  instance_type = "t2.micro"
  user_data=file("installansible.sh")
  subnet_id=aws_subnet.calc-pub.id
  vpc_security_group_ids=[aws_security_group.calc-web-sg.id]
  key_name="Hola"
  
  tags = {
    Name = "K8S-WRKSTN"
  }
}
