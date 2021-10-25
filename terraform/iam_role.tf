data "aws_iam_policy_document" "lambda_role_document" {
  statement {
    sid     = "LambdaAsTrustedEntity"
    effect  = "Allow"
    actions = ["sts:AssuemRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "step_function_role_document" {
  statement {
    sid     = "StepFunctionAsTrustedEntity"
    effect  = "Allow"
    actions = ["sts:AssuemRole"]
    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "eventbridge_role_document" {
  statement {
    sid     = "EventBridgeAsTrustedEntity"
    effect  = "Allow"
    actions = ["sts:AssuemRole"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "limited_concurrency_lambda_role" {
  name               = "LimitedConcurrencyLambdaRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_role_document.json
  tags               = local.tags_common
}

resource "aws_iam_role" "eventbridge_invoke_step_function_role" {
  name               = "EventbridgeInvokeStepFunctionRole"
  assume_role_policy = data.aws_iam_policy_document.eventbridge_role_document.json
  tags               = local.tags_common
}

resource "aws_iam_role_policy_attachment" "eventbridge_invoke_step_function_policy_attachment" {
  role       = aws_iam_role.eventbridge_invoke_step_function_role.name
  policy_arn = aws_iam_policy.start_execution_of_release_lock_step_function_policy.arn
}

resource "aws_iam_role" "acquire_lock_step_function_role" {
  name = "AcquireLockStepFunctionRole"
  assume_role_policy = data.aws_iam_policy_document.step_function_role_document.json
  tags = local.tags_common
}

resource "aws_iam_role_policy_attachment" "acquire_lock_step_function_policy_attachment" {
  role = aws_iam_role.acquire_lock_step_function_role.name
  policy_arn = aws_iam_policy.acquire_lock_step_function_policy.arn
}
