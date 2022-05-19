//creating vpc,nternet gateway

//vpc

locals  {
    common_tags = {
        Name="Ramesh-VPC"
        owner = "ramesh"
        createdOn = "may12"
        Terraformed = "true"
    }
}


resource "aws_vpc" "ramesh" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = local.common_tags
}

# local {
#   availability_zones = ["ap-south-1a","ap-south-1b","ap-south-1c"]
# }

//Internet gateway

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.ramesh.id
  tags = local.common_tags
}

//creating public subnets, public route table

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.ramesh.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone  = "eu-west-1a"
  map_public_ip_on_launch = "true"
  tags = local.common_tags
}


   
resource "aws_route_table" "public_subnet_route_table" {  
  vpc_id = aws_vpc.ramesh.id
  route {
    cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = local.common_tags
}


resource "aws_route_table_association" "public_subnet_route_table_association" {
  count = length(var.public_subnet_cidrs)
  subnet_id      =  element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id =  aws_route_table.public_subnet_route_table.id
} 