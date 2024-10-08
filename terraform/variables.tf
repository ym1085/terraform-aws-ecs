# variables.tf
variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "ap-northeast-2"
}

# ecs task execution role
variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  type        = string
  default     = "ecs-task-exc-role"
}

# ecs cluster name
variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "node-test-cluster"
}

# ecs auto scale role
# variable "ecs_auto_scale_role_name" {
#   description = "ECS auto scale role Name"
#   default = "myEcsAutoScaleRole"
# }

variable "app_image" {
  description = "Docker image to use for the container"
  type        = string
  default     = "6xxxxxxxxxxxx.dkr.ecr.ap-northeast-2.amazonaws.com/nodejs"
}

# availability zones
variable "az_count" {
  description = "Number of AZs to cover in a given region"
  type        = string
  default     = "2"
}

variable "application_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3000
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 3
}

# health check path
variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/health-check"
}

# fargate cpu
variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

# fargate memory
variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

# Public Subnet CIDR Block 시작 값
# 172.21.10.0/24, 172.21.20.0/24, 172.21.30.0/24
variable "public_base_subnet_cidr" {
  description = "Base CIDR block for public subnets"
  type        = list(number)
  default     = [10, 20, 30]
}

# Private Subnet CIDR Block 시작 값
# 172.21.50.0/24, 172.21.60.0/24, 172.21.70.0/24
variable "private_base_subnet_cidr" {
  description = "Increment value for CIDR blocks"
  type        = list(number)
  default     = [50, 60, 70]
}
