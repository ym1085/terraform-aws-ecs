# VPC ID 출력
output "vpc_id" {
  value = aws_vpc.main.id
}

# VPC CIDR Block 출력
output "vpc_cidr_block" {
  value = var.vpc_cidr_block
}

# VPC 이름 출력
output "vpc_name" {
  value = var.vpc_name
}

# 환경 출력
output "environment" {
  value = var.environment
}
