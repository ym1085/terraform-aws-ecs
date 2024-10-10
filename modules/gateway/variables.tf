# VPC ID 지정
variable "vpc_id" {
  type = string
}

# Public Subnet ID 지정
variable "public_subnet_id" {
  type = string
}

# 환경 지정
variable "environment" {
  type = string
}

# 서비스 구분 이름 지정
variable "domain" {
  type = string
}
