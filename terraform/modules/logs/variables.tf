variable "name" {
  description = "Base name for CloudWatch log group"
  type        = string
}

variable "log_retention_days" {
  description = "Log retention period in days"
  type        = number
  default     = 30
}

variable "common_tags" {
  description = "Common tags applied to log resources"
  type        = map(string)
}
