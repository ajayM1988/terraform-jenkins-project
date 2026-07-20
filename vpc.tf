resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

###############################################################################
# Internet Gateway
###############################################################################

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

###############################################################################
# Public Subnet 1
###############################################################################

resource "aws_subnet" "public_subnet_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet_1_cidr

  availability_zone = "ap-south-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-subnet-1"
  }
}

###############################################################################
# Public Subnet 2
###############################################################################

resource "aws_subnet" "public_subnet_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet_2_cidr

  availability_zone = "ap-south-1b"

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-subnet-2"
  }
}

###############################################################################
# Private Subnet 1
###############################################################################

resource "aws_subnet" "private_subnet_1" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.private_subnet_1_cidr

  availability_zone = "ap-south-1a"

  tags = {
    Name = "${var.environment}-private-subnet-1"
  }
}

###############################################################################
# Private Subnet 2
###############################################################################

resource "aws_subnet" "private_subnet_2" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.private_subnet_2_cidr

  availability_zone = "ap-south-1b"

  tags = {
    Name = "${var.environment}-private-subnet-2"
  }
}

###############################################################################
# Public Route Table
###############################################################################

resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.environment}-public-route-table"
  }
}

###############################################################################
# Public Route Table Associations
###############################################################################

resource "aws_route_table_association" "public_subnet_1_association" {

  subnet_id = aws_subnet.public_subnet_1.id

  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_2_association" {

  subnet_id = aws_subnet.public_subnet_2.id

  route_table_id = aws_route_table.public_rt.id
}

###############################################################################
# Private Route Table
###############################################################################

resource "aws_route_table" "private_rt" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-private-route-table"
  }
}

###############################################################################
# Private Route Table Associations
###############################################################################

resource "aws_route_table_association" "private_subnet_1_association" {

  subnet_id = aws_subnet.private_subnet_1.id

  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_subnet_2_association" {

  subnet_id = aws_subnet.private_subnet_2.id

  route_table_id = aws_route_table.private_rt.id
}

#########################
