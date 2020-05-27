variable "name" {
  description = "bucket name (required)"
  type        = string
}

variable "bucket_policy_only" {
  description = "bucket_policy_only"
  type        = bool
  default     = false
}
