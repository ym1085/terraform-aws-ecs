#####################################
# @module: common (공통 변수)
#####################################

# VPC ID 지정
variable "vpc_id" {
  description = "value"
  type        = string
}

# VPC CIDR Block 지정
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
}

# 환경 변수 지정
variable "environment" {
  description = "Deployment Environment"
  type        = string
}

#####################################
# @module: ./vpc/variables.tf (VPC 모듈 변수)
#####################################

# VPC 이름 지정
variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

#####################################
# @module: ./subnets/variables.tf (서브넷 모듈 변수)
#####################################

# 가용영역 개수 지정
variable "az_count" {
  description = "Number of Availability Zones"
  type        = number
}

#####################################
# @module: ./security_groups/variables.tf (보안 그룹 모듈 변수)
#####################################

# ALB Listener Port 지정
variable "alb_listener_port" {
  description = "ALB Listener Port"
  type        = number
}

# Container Port 지정
variable "container_port" {
  description = "Container Port"
  type        = number
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
}

# Container Image 지정
variable "container_image" {
  description = "Container Image"
  type        = string
}
