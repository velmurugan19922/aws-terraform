# Setup EC2 Instance
resource "aws_instance" "small-ec2" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.aws-big-pubsubnet-A.id
  vpc_security_group_ids = [aws_security_group.big-sg.id]
  key_name = "aws-newkey"
  user_data = file("webapp.sh")
  tags = {
    Name = "small-ec2"
  }
}