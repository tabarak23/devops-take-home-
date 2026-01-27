variable "name" {
  description = "Base name for ECS resources"
  type        = string
}

variable "region" {
  description = "AWS region for ECS logging"
  type        = string
}

variable "image" {
  description = "Docker image URI for ECS task"
  type        = string
}

variable "cpu" {
  description = "CPU units for the ECS task"
  type        = number
  default     = 512
}

variable "memory" {
  description = "Memory (MB) for the ECS task"
  type        = number
  default     = 1024
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 8080
}

variable "execution_role_arn" {
  description = "IAM execution role ARN for ECS tasks"
  type        = string
}

variable "task_role_arn" {
  description = "IAM task role ARN for the application"
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch log group name for ECS"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN for ALB integration"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS service"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID for ECS service"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to ECS resources"
  type        = map(string)
}
