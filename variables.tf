variable "lambda_functions" {
  type = map(object({
    archive_file_type        = optional(string, "zip")
    archive_file_source_file = optional(string)
    archive_file_output_path = optional(string)
    description              = optional(string)
    handler                  = optional(string, null)
    runtime                  = optional(string, "python3.10")
    memory_size              = optional(number, 128)
    role_arn                 = optional(string)
    timeout                  = optional(number, 3)
    filename                 = optional(string)
  }))
}

variable "env_variables" {
  type    = map(map(string))
  default = {}
}

variable "vpc_config" {
  type = map(object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  }))
  default = {}
}

variable "role_arns" {
  type    = map(any)
  default = null
}