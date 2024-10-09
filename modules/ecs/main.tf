# ECS Cluster 생성
resource "aws_ecs_cluster" "cluster" {
  name = "${var.environment}-cluster"
}

# data "template_file" "container_definitions" {
#   template = file("./ecs/")
# }

# ECS Task 생성
resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.environment}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_fargate_task_total_cpu
  memory                   = var.ecs_fargate_task_total_mem

  # TODO: 수정 필요
  container_definitions = jsonencode([
    {
      name      = "${var.environment}-container"
      image     = "${var.container_image}"
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# ECS Service 생성
resource "aws_ecs_service" "service" {
  name            = "${var.environment}-service"
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
    container_name   = "${var.environment}-container"
    container_port   = var.container_port
  }

  depends_on = [var.alb_listener_arn]
}

# ECS Task Execution Role 생성
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.environment}-ecs-task-execution-role"

  # TODO: 수정 필요
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# ECS Task Execution Role 정책 추가
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
