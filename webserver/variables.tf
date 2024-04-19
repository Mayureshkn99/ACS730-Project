# Instance type
variable "instance_type" {
  default     = "t2.micro"
  type        = string
  description = "Type of the instance"
}

# Default tags
variable "default_tags" {
  default = {
    "Owner" = "Group 5"
    "App"   = "WebApp"
  }
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}

# Prefix to identify resources
variable "prefix" {
  default     = "group5"
  type        = string
  description = "Name prefix"
}