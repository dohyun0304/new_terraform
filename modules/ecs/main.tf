resource "aws_ecs_cluster" "this" {
  name = var.ecs_cluster_name

  tags = {
    Name = var.ecs_cluster_name
  }
}

resource "aws_ecs_task_definition" "task" {
  family                = var.ecs_cluster_name
  container_definitions = var.ecs_container_definitions

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  tags = {
    Name = "${var.ecs_cluster_name}-task"
  }
}

resource "aws_ecs_service" "service" {
  name            = var.ecs_cluster_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.ecs_desired_count

  network_configuration {
    subnets = var.ecs_subnet_ids
    security_groups = [aws_security_group.ecs_sg.id]
  }

  launch_type = "FARGATE"

  tags = {
    Name = "${var.ecs_cluster_name}-service"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.ecs_cluster_name}-sg"
  description = "ECS Security Group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ecs_ingress_ports
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.ecs_egress_ports
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.ecs_cluster_name}-sg"
  }
}

resource "aws_iam_policy" "ecs_task_execution_policy" {
  name        = "${var.ecs_cluster_name}-task-execution-policy"
  description = "ECS Task Execution Policy for ${var.ecs_cluster_name}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name = "${var.ecs_cluster_name}-task-execution-policy"
  }
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.ecs_cluster_name}-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "${var.ecs_cluster_name}-task-execution-role"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}