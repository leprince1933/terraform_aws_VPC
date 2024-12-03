# create Vpc
resource "aws_vpc" "v1" {
    cidr_block = "172.120.0.0/16"
    instance_tenancy = "default"
    tags = {
      Name = "UTc -app"
      Team = " cloud team"
    }
  
}
# internet gateway
resource "aws_internet_gateway" "gtw" {
    vpc_id = aws_vpc.v1.id
  
}
# pubic
resource "aws_subnet" "pub1" {
    vpc_id = aws_vpc.v1.id
    cidr_block = "172.120.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    
}
resource "aws_subnet" "pub2" {
    vpc_id = aws_vpc.v1.id
    cidr_block = "172.120.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
     
}
# private subnet

resource "aws_subnet" "priv1" {
    vpc_id = aws_vpc.v1.id
    cidr_block = "172.120.3.0/24"
    availability_zone = "us-east-1a"
    
}
resource "aws_subnet" "priv2" {
    vpc_id = aws_vpc.v1.id
    cidr_block = "172.120.4.0/24"
    availability_zone = "us-east-1b"
}
#nat gateway

resource "aws_eip" "eip1" {
  
}

resource "aws_nat_gateway" "nat1" {
    allocation_id = aws_eip.eip1.id
    subnet_id = aws_subnet.pub1.id
  
}

# private route table

resource "aws_route_table" "rtprivate" {
    vpc_id = aws_vpc.v1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat1.id
    }
  
}
#public
resource "aws_route_table" "rtpublic" {
    vpc_id = aws_vpc.v1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gtw.id
    }
  
}

# route table association
resource "aws_route_table_association" "purt1" {
    subnet_id = aws_subnet.pub1.id
    route_table_id = aws_route_table.rtpublic.id
  
}
resource "aws_route_table_association" "purt2" {
    subnet_id = aws_subnet.pub2.id
    route_table_id = aws_route_table.rtpublic.id
  
}

# private route association
resource "aws_route_table_association" "privatet1" {
    subnet_id = aws_subnet.priv1.id
    route_table_id = aws_route_table.rtprivate.id
  
}

resource "aws_route_table_association" "privatet2" {
    subnet_id = aws_subnet.priv2.id
    route_table_id = aws_route_table.rtprivate.id
  
}


