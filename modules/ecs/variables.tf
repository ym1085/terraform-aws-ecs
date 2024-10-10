# Fargate CPU 지정
variable "ecs_fargate_task_total_cpu" {
  type = string
}

# Fargate Memory 지정
variable "ecs_fargate_task_total_mem" {
  type = string
}

# Desired Count 지정
variable "ecs_task_desired_count" {
  type = number
}

# Private Subnet IDs 지정
variable "private_subnet_ids" {
  type = list(string)
}

# ECS Security Group ID 지정
variable "ecs_task_sg_id" {
  type = string
}

# Target Group ARN 지정
variable "alb_target_group_arn" {
  type = string
}

# ALB Listener ARN
variable "alb_listener_arn" {
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

# 서비스 구분 이름 지정
variable "domain" {
  type = string
}
