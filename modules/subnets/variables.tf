# VPC ID 지정
variable "vpc_id" {
  type = string
}

# VPC CIDR Block 지정
variable "vpc_cidr_block" {
  type = string
}

# 가용영역 개수 지정
variable "az_count" {
  type = number
}

# 환경 지정
variable "environment" {
  type = string
}

# 서비스 구분 이름 지정
variable "domain" {
  type = string
}
