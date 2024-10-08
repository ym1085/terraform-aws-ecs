# Public Subnet 생성
# Public Subnet CIDR 172.21.10.0/24, 172.21.20.0/24, 172.21.30.0/24
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, (count.index + 1) * 10)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment}-public-subnet-${count.index}"
  }
}

# Private Subnet 생성
# Private Subnet CIDR 172.21.50.0/24, 172.21.60.0/24, 172.21.70.0/24
resource "aws_subnet" "private" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, (count.index + 5) * 10)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.environment}-private-subnet-${count.index}"
  }
}
