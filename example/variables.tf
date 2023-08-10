variable "lambda_functions" {
  type = map(object({
    role_arn = string
  }))
  default = {
    "lambda_function_name" = {
      role_arn = ""
    }
  }
}

variable "env_variables" {
  type = map(map(string))
  default = {
    "lambda_function_name" = {
      "key" = "value"
    }
  }
}