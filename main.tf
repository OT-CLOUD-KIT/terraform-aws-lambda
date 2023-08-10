data "archive_file" "for" {
  for_each    = var.lambda_functions
  type        = each.value.archive_file_type
  source_file = each.value.archive_file_source_file != null ? each.value.archive_file_source_file : "${path.root}/lambda_functions/${each.key}.py"
  output_path = each.value.archive_file_output_path != null ? each.value.archive_file_output_path : "${each.key}.zip"
}

resource "aws_lambda_function" "for" {
  for_each         = var.lambda_functions
  function_name    = each.key
  description      = each.value.description
  handler          = each.value.handler != null ? each.value.handler : "${each.key}.lambda_handler"
  runtime          = each.value.runtime
  memory_size      = each.value.memory_size
  timeout          = each.value.timeout
  role             = each.value.role_arn != null ? each.value.role_arn : var.role_arns[each.key]
  filename         = each.value.filename != null ? each.value.filename : "${each.key}.zip"
  source_code_hash = data.archive_file.for[each.key].output_base64sha256

  dynamic "environment" {
    for_each = { for value in toset(keys(var.env_variables)) : value => var.env_variables[value] if value == "${each.key}" }
    content {
      variables = environment.value
    }
  }

  dynamic "vpc_config" {
    for_each = { for value in toset(keys(var.vpc_config)) : value => var.vpc_config[value] if value == "${each.key}" }
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }
  }
}


