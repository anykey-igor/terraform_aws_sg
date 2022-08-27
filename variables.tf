#---------------------------------------------------------------------------------------------------------------------
# General Variables
#---------------------------------------------------------------------------------------------------------------------
variable "region" {
  description = "The region where to deploy this code (e.g. eu-center-1)"
  type        = string
  default     = "eu-central-1"
}
variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
  default     = "LAUNCH-TEMPLATE"
}
variable "environment" {
  description = "Environment for service"
  type        = string
  default     = "DEMO"
}
variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------------------------------------------------------------------------
# Variable for AWS Launch Template
#---------------------------------------------------------------------------------------------------------------------