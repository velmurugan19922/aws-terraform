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
  map_public_ip_on_launch = "false"
  cidr_block = "10.0.32.0/20"

  tags = {
    Name = "aws-big-pvtsubnet-A"
  }
}
# create subnet private-B
resource "aws_subnet" "aws-big-pvtsubnet-B" {
  vpc_id     = aws_vpc.aws-big-vpc.id
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = "false"
  cidr_block = "10.0.48.0/20"

  tags = {
    Name = "aws-big-pvtsubnet-B"
  }
}
# create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws-big-vpc.id

  tags = {
    Name = "big-igw"
  }
}

# create public route table

resource "aws_route_table" "big-pubrt" {
  vpc_id = aws_vpc.aws-big-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "big-pubrt"
  }
}

#create public route table

resource "aws_route_table" "big-pvtrt" {
  vpc_id = aws_vpc.aws-big-vpc.id

  tags = {
    Name = "big-pvtrt"
  }
}
#public subnet association-a
resource "aws_route_table_association" "pub-sub-ass-a" {
  subnet_id      = aws_subnet.aws-big-pubsubnet-A.id
  route_table_id = aws_route_table.big-pubrt.id
}
#public subnet association-b
resource "aws_route_table_association" "pub-sub-ass-b" {
  subnet_id      = aws_subnet.aws-big-pubsubnet-B.id
  route_table_id = aws_route_table.big-pubrt.id
}
#private subnet association-a
resource "aws_route_table_association" "pvt-sub-ass-a" {
  subnet_id      = aws_subnet.aws-big-pvtsubnet-A.id
  route_table_id = aws_route_table.big-pvtrt.id
}
#private subnet association-b
resource "aws_route_table_association" "pvt-sub-ass-b" {
  subnet_id      = aws_subnet.aws-big-pvtsubnet-B.id
  route_table_id = aws_route_table.big-pvtrt.id
}
# Security Group - SSH & HTTP
resource "aws_security_group" "big-sg" {
  name        = "allow_web"
  description = "Allow SSH & HTTP inbound traffic"
  vpc_id      = aws_vpc.aws-big-vpc.id

  ingress {
    description      = "SSH from www"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   ingress {
    description      = "HTTP from www"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "big-sg"
  }
}