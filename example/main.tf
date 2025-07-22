module "lambda" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-lambda.git?ref=Feature"  # Adjust path as needed

  lambda_function = var.lambda_function
  lambda_layers   = var.lambda_layers
}
