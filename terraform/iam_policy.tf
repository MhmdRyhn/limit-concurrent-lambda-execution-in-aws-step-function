data "aws_iam_policy_document" "acquire_lock_step_function_policy_document" {
  statement {
    sid = "DynamoDBOperation"
    effect = "Allow"
    actions = [
      "dynamodb:UpdateItem",
    ]
    resources = [aws_dynamodb_table.sf_execution_lock_table.arn]
  }
}

resource "aws_iam_policy" "acquire_lock_step_function_policy" {
  name = "AcquireLockStepFunctionPolicy"
  policy = data.aws_iam_policy_document.acquire_lock_step_function_policy_document.json
  tags = local.tags_common
}

data "aws_iam_policy_document" "start_execution_of_release_lock_step_function_policy_document" {
  statement {
    sid    = "StartStepFunctionExecution"
    effect = "Allow"
    actions = [
      "states:StartExecution",
      "states:StartSyncExecution"
    ]
    resources = [aws_sfn_state_machine.release_lock_step_function.arn]
  }
}

resource "aws_iam_policy" "start_execution_of_release_lock_step_function_policy" {
  name   = "StartExecutionOfReleaseLockStepFunctionPolicy"
  policy = data.aws_iam_policy_document.start_execution_of_release_lock_step_function_policy_document.json
  tags   = local.tags_common
}
