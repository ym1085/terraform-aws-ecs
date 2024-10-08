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

resource "aws_subnet" "public_subnet" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true # public IP 할당 여부
}

resource "aws_subnet" "private_subnet" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.main.id
}