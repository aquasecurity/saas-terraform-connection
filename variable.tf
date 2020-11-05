variable "account_id" {}

variable cloudsploit_external_id {}

variable "use_aws_gov" {
  default     = false
  description = "This is used to toggle which role policy will be used, by default it assumes you are not in government cloud."
}

variable "enabled" {
  default     = false
  description = "Enable module or not."
}
