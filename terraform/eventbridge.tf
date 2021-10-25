resource "aws_cloudwatch_event_rule" "capture_step_function_failure" {
  name          = "${local.prefix}-capture-step-function-failure"
  description   = "Captures the event when step function is FAILED, TIMED_OUT or ABORTED."
  event_pattern = <<PATTERN
{
  "source": ["aws.states"],
  "detail-type": ["Step Functions Execution Status Change"],
  "detail": {
    "status": ["FAILED", "ABORTED", "TIMED_OUT"],
    "stateMachineArn": [${aws_sfn_state_machine.main_task_step_function.arn}]
  }
}
PATTERN
  tags          = local.tags_common
}

resource "aws_cloudwatch_event_target" "capture_step_function_failure_target" {
  rule     = aws_cloudwatch_event_rule.capture_step_function_failure.name
  arn      = aws_sfn_state_machine.release_lock_step_function.arn
  role_arn = aws_iam_role.eventbridge_invoke_step_function_role.arn
}
