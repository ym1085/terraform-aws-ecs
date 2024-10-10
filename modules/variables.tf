#####################################
# @module: common (공통 변수)
#####################################

# VPC CIDR Block 지정
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "172.21.0.0/16"
}

# 환경 변수 지정
variable "environment" {
  description = "Deployment Environment"
  type        = string
  default     = "dev"
}

variable "domain" {
  description = "서비스 메인 이름 지정"
  type        = string
  default     = "search"
}

#####################################
# @module: ./vpc/variables.tf (VPC 모듈 변수)
#####################################

# VPC 이름 지정
variable "vpc_name" {
  description = "VPC 이름 지정"
  type        = string
  default     = "search-vpc"
}

#####################################
# @module: ./subnets/variables.tf (서브넷 모듈 변수)
#####################################

# 가용영역 개수 지정
variable "az_count" {
  description = "가용영역 개수 지정"
  type        = number
  default     = 2
}

#####################################
# @module: ./security_groups/variables.tf (보안 그룹 모듈 변수)
#####################################

# ALB Listener Port 지정
variable "alb_listener_port" {
  description = "ALB Listener Port"
  type        = number
  default     = 80
}

# Container Port 지정
variable "container_port" {
  description = "Container Port"
  type        = number
  default     = 3000
}

#####################################
# @module: ./route_tables/variables.tf (라우팅 테이블 모듈 변수)
#####################################

#####################################
# @module: ./ecs/variables.tf (ECS 모듈 변수)
#####################################

# Fargate CPU 지정
variable "ecs_fargate_task_total_cpu" {
  description = "Fargate CPU Size"
  type        = string
}

# Fargate Memory 지정
variable "ecs_fargate_task_total_mem" {
  description = "Fargate Memory Size"
  type        = string
}

# Desired Count 지정
variable "ecs_task_desired_count" {
  description = "Desired Task Count for ECS"
  type        = number
  default     = 1
}

# Container Image 지정
variable "container_image" {
  description = "Container Image"
  type        = string
}
