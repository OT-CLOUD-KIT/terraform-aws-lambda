# Terraform AWS Lambda Module

A flexible and reusable **Terraform module** to create and manage an [AWS Lambda Function](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html), with optional layers, environment variables, VPC configuration, permissions, and function URL support.

---

## Architecture

![Screenshot from 2025-07-04 00-28-16](https://github.com/user-attachments/assets/116e8ac0-4de3-4a88-9caf-98bf367c3a2c)


This module allows you to deploy:

- A Lambda function with custom runtime, memory, timeout, and handler.
- Optional Lambda layers (custom or S3-based).
- Environment variables support.
- VPC configuration (subnets + security groups).
- Lambda permissions (triggers).
- Public/private Function URL with optional CORS.
  
> **Note**: The module supports fine-grained configuration using input objects for maximum flexibility.

---



## Usage

```hcl
module "lambda" {
  source = ""

  lambda_function = {
    name        = "ot-dev-lambda"
    runtime     = "python3.13"
    memory_size = 700
    timeout     = 50
    handler     = "lambda_function.lambda_handler"
    layers_name = ["xyz"]
    filename    = "lambda_function_payload.zip"
    role_arn    = "arn:aws:iam::123456789012:role/lambda_execution_role"

    env_variables = {
      name = "demo"
      env  = "test"
    }

    vpc_config = {
      security_group_ids = ["sg-04fb2f273d8865af3"]
      subnet_ids         = ["subnet-0a49bf4221b5f0107", "subnet-08a2aa30dbc179a2b"]
    }

    triggers = {
      "event-trigger" = {
        principal  = "events.amazonaws.com"
        source_arn = "arn:aws:s3:::example-bucket"
      }
    }

    function_url = {
      authorization_type = "NONE"
    }
  }

  lambda_layers = {
    "xyz" = {
      compatible_runtimes      = ["python3.9"]
      filename                 = "lambda_layer_payload.zip"
      compatible_architectures = ["x86_64"]
    }
  }
}

```
##  Resources

| Name | Type |
|------|------|
| [aws_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_layer_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |
| [aws_lambda_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_function_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_url) | resource |


##  Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lambda_function"></a> [lambda_function](#input_lambda_function) | Object containing configuration for the Lambda function, including name, runtime, memory, VPC config, triggers, and more. | `map(any)` | n/a | yes|
| <a name="input_lambda_function.name"></a> [lambda_function.name](#input_lambda_function.name) | Name of the Lambda function. | `string` | n/a | yes |
| <a name="input_lambda_function.runtime"></a> [lambda_function.runtime](#input_lambda_function.runtime) | Runtime environment (e.g. `python3.13`). | `string` | n/a | yes|
| <a name="input_lambda_function.handler"></a> [lambda_function.handler](#input_lambda_function.handler) | Function handler (e.g. `lambda_function.lambda_handler`). | `string` | n/a | yes |
| <a name="input_lambda_function.memory_size"></a> [lambda_function.memory_size](#input_lambda_function.memory_size) | Amount of memory in MB. | `number` | `128` | No |
| <a name="input_lambda_function.timeout"></a> [lambda_function.timeout](#input_lambda_function.timeout) | Timeout in seconds. | `number` | `3` | No |
| <a name="input_lambda_function.filename"></a> [lambda_function.filename](#input_lambda_function.filename) | Zip file containing Lambda source code. | `string` | n/a | yes |
| <a name="input_lambda_function.role_arn"></a> [lambda_function.role_arn](#input_lambda_function.role_arn) | ARN of the IAM role for Lambda. | `string` | n/a | yes |
| <a name="input_lambda_function.env_variables"></a> [lambda_function.env_variables](#input_lambda_function.env_variables) | Environment variables for the Lambda function. | `map(string)` | `{}` | No |
| <a name="input_lambda_function.vpc_config"></a> [lambda_function.vpc_config](#input_lambda_function.vpc_config) | VPC configuration block with subnet and security group IDs. | `map(any)` | `null` | No |
| <a name="input_lambda_function.triggers"></a> [lambda_function.triggers](#input_lambda_function.triggers) | Map of triggers (e.g. EventBridge, S3) for permissions. | `map(any)` | `{}` | No|
| <a name="input_lambda_function.function_url"></a> [lambda_function.function_url](#input_lambda_function.function_url) | Configuration for Lambda function URL (if used). | `map(any)` | `null` | No |
| <a name="input_lambda_function.layers_name"></a> [lambda_function.layers_name](#input_lambda_function.layers_name) | List of custom Lambda layer names. | `list(string)` | `[]` | No |
| <a name="input_lambda_function.layers_arn"></a> [lambda_function.layers_arn](#input_lambda_function.layers_arn) | List of external layer ARNs. Used if `layers_name` is not provided. | `list(string)` | `null` | No |
| <a name="input_lambda_layers"></a> [lambda_layers](#input_lambda_layers) | Map of Lambda layer definitions. | `map(any)` | `{}` | No |


___





## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda function |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda function |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | The Invoke ARN of the Lambda function |
| <a name="output_lambda_function_url"></a> [lambda\_function\_url](#output\_lambda\_function\_url) | URL to invoke the Lambda function |



## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)

