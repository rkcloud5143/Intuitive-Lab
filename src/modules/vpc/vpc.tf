resource "aws_vpc" "intuitiveVPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name    = "intuitiveVPC"
    Project = "intuitive development env"
  }
}

resource "aws_internet_gateway" "intuitiveIGW" {
  vpc_id = aws_vpc.intuitiveVPC.id
  tags = {
    Name    = "intuitiveIGW"
    Project = "intuitive development env"
  }
}

resource "aws_eip" "intuitiveNatGatewayEIP1" {
  tags = {
    Name    = "intuitiveNatGatewayEIP1"
    Project = "intuitive development env"
  }
}
resource "aws_nat_gateway" "intuitiveNatGateway1" {
  allocation_id = aws_eip.intuitiveNatGatewayEIP1.id
  subnet_id     = aws_subnet.intuitivePublicSubnet1.id
  tags = {
    Name    = "intuitiveNatGateway1"
    Project = "intuitive development env"
  }
}
resource "aws_subnet" "intuitivePublicSubnet1" {
  vpc_id            = aws_vpc.intuitiveVPC.id
  cidr_block        = var.public_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name    = "intuitivePublicSubnet1"
    Project = "intuitive development env"
  }
}

resource "aws_eip" "intuitiveNatGatewayEIP2" {
  tags = {
    Name    = "intuitiveNatGatewayEIP2"
    Project = "intuitive development env"
  }
}
resource "aws_nat_gateway" "intuitiveNatGateway2" {
  allocation_id = aws_eip.intuitiveNatGatewayEIP2.id
  subnet_id     = aws_subnet.intuitivePublicSubnet1.id
  tags = {
    Name    = "intuitiveNatGateway2"
    Project = "intuitive development env"
  }
}
resource "aws_subnet" "intuitivePublicSubnet2" {
  vpc_id            = aws_vpc.intuitiveVPC.id
  cidr_block        = var.public_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name    = "intuitivePublicSubnet2"
    Project = "intuitive development env"
  }
}

resource "aws_eip" "intuitiveNatGatewayEIP3" {
  tags = {
    Name    = "intuitiveNatGatewayEIP3"
    Project = "intuitive development env"
  }
}
resource "aws_nat_gateway" "intuitiveNatGateway3" {
  allocation_id = aws_eip.intuitiveNatGatewayEIP3.id
  subnet_id     = aws_subnet.intuitivePublicSubnet1.id
  tags = {
    Name    = "intuitiveNatGateway3"
    Project = "intuitive development env"
  }
}
resource "aws_subnet" "intuitivePublicSubnet3" {
  vpc_id            = aws_vpc.intuitiveVPC.id
  cidr_block        = var.public_subnet_cidrs[2]
  availability_zone = var.availability_zones[2]
  tags = {
    Name    = "intuitivePublicSubnet3"
    Project = "intuitive development env"
  }
}

resource "aws_subnet" "intuitivePrivateSubnet1" {
  vpc_id            = aws_vpc.intuitiveVPC.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name    = "intuitivePrivateSubnet1"
    Project = "intuitive development env"
  }
}
resource "aws_subnet" "intuitivePrivateSubnet2" {
  vpc_id            = aws_vpc.intuitiveVPC.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name    = "intuitivePrivateSubnet2"
    Project = "intuitive development env"
  }
}
resource "aws_subnet" "intuitivePrivateSubnet3" {
  vpc_id            = aws_vpc.intuitiveVPC.id
  cidr_block        = var.private_subnet_cidrs[2]
  availability_zone = var.availability_zones[2]
  tags = {
    Name    = "intuitivePrivateSubnet3"
    Project = "intuitive development env"
  }
}

resource "aws_route_table" "intuitivePublicRT" {
  vpc_id = aws_vpc.intuitiveVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.intuitiveIGW.id
  }
  tags = {
    Name    = "intuitivePublicRT"
    Project = "intuitive development env"
  }
}
resource "aws_route_table" "intuitivePrivateRT1" {
  vpc_id = aws_vpc.intuitiveVPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.intuitiveNatGateway1.id
  }
  tags = {
    Name    = "intuitivePrivateRT1"
    Project = "intuitive development env"
  }
}
resource "aws_route_table" "intuitivePrivateRT2" {
  vpc_id = aws_vpc.intuitiveVPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.intuitiveNatGateway2.id
  }
  tags = {
    Name    = "intuitivePrivateRT2"
    Project = "intuitive development env"
  }
}
resource "aws_route_table" "intuitivePrivateRT3" {
  vpc_id = aws_vpc.intuitiveVPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.intuitiveNatGateway3.id
  }
  tags = {
    Name    = "intuitivePrivateRT3"
    Project = "intuitive development env"
  }
}

resource "aws_route_table_association" "intuitivePublicRTassociation1" {
  subnet_id      = aws_subnet.intuitivePublicSubnet1.id
  route_table_id = aws_route_table.intuitivePublicRT.id
}
resource "aws_route_table_association" "intuitivePublicRTassociation2" {
  subnet_id      = aws_subnet.intuitivePublicSubnet2.id
  route_table_id = aws_route_table.intuitivePublicRT.id
}
resource "aws_route_table_association" "intuitivePublicRTassociation3" {
  subnet_id      = aws_subnet.intuitivePublicSubnet3.id
  route_table_id = aws_route_table.intuitivePublicRT.id
}
resource "aws_route_table_association" "intuitivePrivateRTassociation1" {
  subnet_id      = aws_subnet.intuitivePrivateSubnet1.id
  route_table_id = aws_route_table.intuitivePrivateRT1.id
}
resource "aws_route_table_association" "intuitivePrivateRTassociation2" {
  subnet_id      = aws_subnet.intuitivePrivateSubnet2.id
  route_table_id = aws_route_table.intuitivePrivateRT2.id
}
resource "aws_route_table_association" "intuitivePrivateRTassociation3" {
  subnet_id      = aws_subnet.intuitivePrivateSubnet3.id
  route_table_id = aws_route_table.intuitivePrivateRT3.id
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_all"
  description = "Allow all communication"
  vpc_id      = aws_vpc.intuitiveVPC.id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.intuitiveVPC.cidr_block, "0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_all_communication"
  }
}