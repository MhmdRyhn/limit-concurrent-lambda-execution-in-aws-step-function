locals {
  prefix = "${var.module}-${var.environment}"
  tags_common = {
    module      = var.module
    environment = var.environment
  }
}

locals {
  throttling_operation_lambda_config = {
    name    = "${local.prefix}-throttling-operation-lambda"
    handler = "limited_concurrency_lambda.function.handler"
    runtime = "python3.8"
    timeout = 30 # Seconds
  }
}
