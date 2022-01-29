resource "aws_vpc" "main_dev_vpc" {
  cidr_block           = "10.55.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "MainDevVPC"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "dev_public_subnet" {
  vpc_id                  = aws_vpc.main_dev_vpc.id
  cidr_block              = "10.55.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "DevPublicSubnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_dev_vpc.id

  tags = {
    Name = "DevIGW"
  }
}

resource "aws_route_table" "dev_public_rt" {
  vpc_id = aws_vpc.main_dev_vpc.id

  tags = {
    Name = "DevPublicRT"
  }

}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.dev_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "dev_public_assoc" {
  subnet_id      = aws_subnet.dev_public_subnet.id
  route_table_id = aws_route_table.dev_public_rt.id
}