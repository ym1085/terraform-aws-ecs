# 사용 가능한 가용영역 조회
data "aws_availability_zones" "available" {}

# VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default" # 인스턴스 테넌시 설정 + default(가상화 EC2 호스트 사용)
  tags = {
    Name = var.vpc_name
    Env  = var.environment
  }
}
