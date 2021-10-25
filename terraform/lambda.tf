resource "aws_lambda_function" "throttling_operation_lambda" {
  function_name    = local.throttling_operation_lambda_config.name
  description      = "Lambda function that makes huge number of external API call per second. Default concurrent execution of this lambda function produce API throttling error."
  role             = aws_iam_role.limited_concurrency_lambda_role.arn
  handler          = local.throttling_operation_lambda_config.handler
  runtime          = local.throttling_operation_lambda_config.runtime
  timeout          = local.throttling_operation_lambda_config.timeout
  filename         = "${path.module}/limited_concurrency_lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/limited_concurrency_lambda.zip")
  tags             = local.tags_common
}
