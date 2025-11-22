###########################################
# VPC + Public Subnets + IGW + Routing
###########################################

resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = "${var.project}-${var.region}-vpc"
    },
    var.tags
  )
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = "${var.project}-${var.region}-igw"
    },
    var.tags
  )
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = null   # AWS will auto-pick
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.project}-${var.region}-public-${replace(each.value, "/", "-")}"
    },
    var.tags
  )
}

# Route Table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = "${var.project}-${var.region}-public-rt"
    },
    var.tags
  )
}

# Default route to Internet Gateway
resource "aws_route" "public_inet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# Associate public subnets with route table
resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
