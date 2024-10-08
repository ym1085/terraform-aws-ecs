# Fargate CPU 지정
variable "fargate_cpu" {
  type = string
}

# Fargate Memory 지정
variable "fargate_memory" {
  type = string
}

# Desired Count 지정
variable "desired_count" {
  type = number
}

# Private Subnet IDs 지정
variable "private_subnet_ids" {
  type = list(string)
}

# ECS Security Group ID 지정
variable "ecs_sg_id" {
  type = string
}

# Target Group ARN 지정
variable "target_group_arn" {
  type = string
}

# 환경 변수 지정
variable "environment" {
  type = string
}

# Container Image 지정
variable "container_image" {
  type = string
}

# Container Port 지정
variable "container_port" {
  type = number
}
