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