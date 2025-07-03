module "lambda" {
  source = "../"  # Adjust path as needed

  lambda_function = var.lambda_function
  lambda_layers   = var.lambda_layers
}