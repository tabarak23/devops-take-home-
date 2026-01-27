variable "name" {
  description = "Base name for IAM resources"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to IAM resources"
  type        = map(string)
}
