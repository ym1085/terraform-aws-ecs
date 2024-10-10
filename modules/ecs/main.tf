# 기존에 존재하는 ecs-task-exc-role을 참조
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-exc-role"
}

# Task 파일 읽어서 변수 셋팅
data "template_file" "container_definitions" {
  template = file("${path.module}/task_definitions.tpl")
  vars = {
    domain          = var.domain
    environment     = var.environment
    container_image = var.container_image
    container_port  = var.container_port
  }
}

# ECS Cluster 생성
resource "aws_ecs_cluster" "cluster" {
  name = "${var.domain}-cluster-${var.environment}"
}

# ECS Task 생성
resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.domain}-task-${var.environment}"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn # ecs task execution role 참조
  network_mode             = "awsvpc"                                      # Fargate의 network mode는 awsvpc만 지원(Task 별 ENI 할당)
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_fargate_task_total_cpu
  memory                   = var.ecs_fargate_task_total_mem

  # Task Definition 파일을 읽어온다
  container_definitions = data.template_file.container_definitions.rendered
}

# ECS Service 생성
resource "aws_ecs_service" "service" {
  name            = "${var.domain}-service-${var.environment}"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  launch_type     = "FARGATE"
  desired_count   = var.ecs_task_desired_count

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_task_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "${var.domain}-container-${var.environment}"
    container_port   = var.container_port
  }

  depends_on = [var.alb_listener_arn]
}

# ECS Task Execution Role 정책 추가
# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
#   role       = data.aws_iam_role.ecs_task_execution_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }
