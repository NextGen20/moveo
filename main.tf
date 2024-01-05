#Configures the AWS provider for the specified region.
provider "aws" {
  region = "us-east-1" # Change this to your AWS region
}

#Creates a Virtual Private Cloud (VPC) with the CIDR block "10.0.0.0/16" and enables DNS support and hostnames.
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

#Defines a public subnet within the VPC with a CIDR block of "10.0.1.0/24" and enables automatic assignment of public IP addresses to instances launched in this subnet.
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
}

#Defines a private subnet within the VPC with a CIDR block of "10.0.2.0/24."
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
}

#Creates an Internet Gateway and associates it with the VPC to allow internet connectivity.
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id
}

#Allocates an Elastic IP and creates a NAT Gateway in the public subnet, associating it with the EIP.
resource "aws_eip" "nat" {
  vpc = true
}

#Defines a public route table and sets a default route to the Internet Gateway.
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

#Associates the public route table with the public subnet.
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

#Defines a private route table and sets a default route to the NAT Gateway.
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

#Associates the private route table with the private subnet.
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

#Launches an instance in the private subnet.
resource "aws_instance" "private_instance" {
  ami           = "ami-0c7217cdde317cfec" # Replace with your AMI ID
  instance_type = "t2.micro"              # Update instance type as necessary
  subnet_id     = aws_subnet.private_subnet.id
  key_name      = "sec-key"    # Replace with your key pair name

  tags = {
    Name = "PrivateInstance"
  }
}
