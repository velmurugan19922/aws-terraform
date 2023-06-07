#create vpc
resource "aws_vpc" "aws-big-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "aws-big-vpc"
  }
}
# create subnet public-A
resource "aws_subnet" "aws-big-pubsubnet-A" {
  vpc_id     = aws_vpc.aws-big-vpc.id
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = "true"
  cidr_block = "10.0.0.0/20"

  tags = {
    Name = "aws-big-pubsubnet-A"
  }
}
# create subnet public-B
resource "aws_subnet" "aws-big-pubsubnet-B" {
  vpc_id     = aws_vpc.aws-big-vpc.id
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = "true"
  cidr_block = "10.0.16.0/20"

  tags = {
    Name = "aws-big-pubsubnet-B"
  }
}
# create subnet private-A
resource "aws_subnet" "aws-big-pvtsubnet-A" {
  vpc_id     = aws_vpc.aws-big-vpc.id
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = "true"
  cidr_block = "10.0.32.0/20"

  tags = {
    Name = "aws-big-pvtsubnet-A"
  }
}