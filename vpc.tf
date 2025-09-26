# VPC
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.project_name}-vpc1"
    Managed_by = "${var.managed_by}"
  }
}

# igw
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${var.project_name}-igw1"
    Managed_by = "${var.managed_by}"
  }
}


# public subnet 1
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.1.0/24"

 
  tags = {
    Name = "${var.project_name}-public-subnet1"
    Managed_by = "${var.managed_by}"
  }
}

# private subnet 1
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"

 tags = {
    Name = "${var.project_name}-private-subnet1"
    Managed_by = "${var.managed_by}"
  }
}

#nat
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.private_subnet1.id

  tags = {
    Name = "${var.project_name}-nat1"
    Managed_by = "${var.managed_by}"
  }


  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw1]
}

# public rt 1
resource "aws_route_table" "public_rt1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "${var.project_name}-public-rt1"
    Managed_by = "${var.managed_by}"
  }
}
# private rt 1
resource "aws_route_table" "private_rt1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${var.project_name}-private-rt1"
    Managed_by = "${var.managed_by}"
  }
}
# public subnet 1 association
resource "aws_route_table_association" "public_subnet1_rt1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt1.id
}
# private subnet 1 association
resource "aws_route_table_association" "private_subnet1_rt1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rt1.id
}

