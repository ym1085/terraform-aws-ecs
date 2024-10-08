# VPC CIDR Block 지정
variable "cidr_block" {
  type        = string
  description = "VPC CIDR Block"
}

# VPC 이름 지정
variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

# 환경 지정
variable "environment" {
  type        = string
  description = "Environment"
}
