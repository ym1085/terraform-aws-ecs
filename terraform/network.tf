# network.tf

# Fetch AZs in the current region
# 사용 가능한 가용영역 조회
data "aws_availability_zones" "available" {
}

# VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = "172.21.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default" # 인스턴스 테넌시 설정 + default(가상화 EC2 호스트 사용)
  tags = {
    Name = "jenkins-test-vpc"
    Env  = "dev"
  }
}

# Public Subnet 생성
# cidrsubnet(prefix, newbits, netnum)
# prefix: 기존 CIDR 블록
# newbits: 서브넷을 만들기 위해 추가할 비트 수, ex) 기존 /16 -> '8' 지정 -> /24 서브넷 생성
# netnum: 서브넷 번호
resource "aws_subnet" "public_subnet" {
  count = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, (count.index + 10) * 1)
  # cidr_block              = "172.21.${var.public_base_subnet_cidr[count.index]}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true # public IP 할당 여부
}

# Private Subnet 생성
resource "aws_subnet" "private_subnet" {
  count = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, (count.index + 50) * 1)
  # cidr_block        = "172.21.${var.private_base_subnet_cidr[count.index]}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.main.id
}

# Internet Gateway 생성
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# main_route_table: vpc 생성 시 AWS가 자동으로 생성하는 기본 라우트 테이블 ID 참조
# default_route_table_id: 기본 라우트 테이블 ID 참조, 이름만 다를 뿐 2개가 기능상으로는 동일
resource "aws_route" "public" {
  route_table_id         = aws_vpc.main.main_route_table_id # VPC의 기본 라우트 테이블 ID 참조
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id # 0.0.0.0/0 모든 트래픽을 IGW로 라우팅
}

# NAT에 사용할 EIP 생성
resource "aws_eip" "gw" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.gw ] # IGW가 존재해야 EIP 생성 가능
}

# Public Subnet A zone에 NAT Gateway 생성
resource "aws_nat_gateway" "gw" {
  subnet_id = aws_subnet.public_subnet[0].id # 172.21.10.0/24 a zone에 NAT 생성
  allocation_id = aws_eip.gw.id
}

# Private Subnet에 대한 라우팅 테이블 생성
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0" # 0.0.0.0/0 모든 트래픽을 NAT Gateway로 라우팅
    nat_gateway_id = aws_nat_gateway.gw.id
  }
}

# Private Subnet과 프라이빗 라우팅 테이블 연결
resource "aws_route_table_association" "private" {
  count = var.az_count
  subnet_id = element(aws_subnet.private_subnet.*.id, count.index) # 프라이빗 서브넷 ID 참조
  route_table_id = aws_route_table.private.id # 프라이빗 라우팅 테이블과 연결
}