module "lambda" {
  source           = "../../../modules/lambda"
  lambda_functions = var.lambda_functions
  env_variables    = local.env_variables
}