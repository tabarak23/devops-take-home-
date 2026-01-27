output "autoscaling_target_resource_id" {
  description = "App Auto Scaling target resource ID"
  value       = aws_appautoscaling_target.ecs.resource_id
}

output "autoscaling_policy_name" {
  description = "Name of the autoscaling policy"
  value       = aws_appautoscaling_policy.cpu.name
}
