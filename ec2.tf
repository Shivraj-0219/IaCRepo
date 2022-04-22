#EC2 Resources
resource "aws_instance" "hdfc-ec2" {

  ami           = "ami-region-dummy"
  instance_type = "t2.micro"
  user_data=file("angularweb.sh")
  subnet_id=aws_subnet.hdfc-pub.id
  vpc_security_group_ids=[aws_security_group.hdfc-web-sg.id]
  key_name="Hola"
  
  tags = {
    Name = "HDFC-WEB-EC2"
  }
}
