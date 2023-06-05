resource "aws_ebs_volume" "aws-demo-v1" {
  availability_zone = "eu-north-1a"
  size              = 5

  tags = {
    Name = "demo-v1"
  }
}