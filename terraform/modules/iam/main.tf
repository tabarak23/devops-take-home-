# =========================
# ECS Task Execution Role
# =========================

resource "aws_iam_role" "ecs_execution" {
  name = "${var.name}-ecs-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_exec_policy" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# =========================
# ECS Task Role (App)
# =========================

resource "aws_iam_role" "ecs_task" {
  name = "${var.name}-ecs-task-role"

  assume_role_policy = aws_iam_role.ecs_execution.assume_role_policy
}
