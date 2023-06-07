#create vpc
resource "aws_vpc" "aws-big-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "aws-big-vpc"
  }
}