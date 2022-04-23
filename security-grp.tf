#SECURITY GROUP
resource "aws_security_group" "calc-web-sg" {
  name        = "calc-web-sg"
  description = "Allow SSH/HTTP Inbound Traffic"
  vpc_id      = aws_vpc.calc.id
  ingress {
    description      = "SSH From WWW"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTP From WWW"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "CALC-WEB-SG"
  }
}
