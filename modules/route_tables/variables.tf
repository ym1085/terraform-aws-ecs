variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "internet_gateway_id" {
  type = string
}

variable "nat_gateway_id" {
  type = string
}

variable "environment" {
  type = string
}

# 서비스 구분 이름 지정
variable "domain" {
  type = string
}
