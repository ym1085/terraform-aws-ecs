# VPC ID 지정
variable "vpc_id" {
  type = string
}

# 퍼블릭 서브넷 ID 지정
variable "public_subnet_ids" {
  type = list(string)
}

# ALB Security Group ID 지정
variable "alb_sg_id" {
  type = string
}

# ALB Listener Port 지정
variable "alb_listener_port" {
  type = number
}

# Container Port 지정
variable "container_port" {
  type = number
}

# 환경 변수 지정
variable "environment" {
  type = string
}

# 서비스 구분 이름 지정
variable "domain" {
  type = string
}
