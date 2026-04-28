resource "aws_instance" "frontend_server" {
  ami                    = "ami-0f58b397bc5c1f2e8"
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "your-keypair-name"

  tags = {
    Name = "Frontend-Server"
  }
}
