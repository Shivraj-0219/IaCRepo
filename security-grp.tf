#SECURITY GROUP
resource "aws_security_group" "hdfc-web-sg" {
  name        = "hdfc-web-sg"
  description = "Allow SSH/HTTP Inbound Traffic"
  vpc_id      = aws_vpc.hdfc.id

  ingress {
    description      = "SSH From WWW"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.hdfc.cidr_block]
    cidr_blocks      = ["0.0.0.0/0]
    
  }
  
  ingress {
    description      = "HTTP From WWW"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.hdfc.cidr_block]
    cidr_blocks      = ["0.0.0.0/0]
    
  }
  
  tags = {
    Name = "HDFC-WEB-SG"
  }
}
