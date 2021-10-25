resource "aws_dynamodb_table" "sf_execution_lock_table" {
  name           = "${local.prefix}-sf-execution-lock-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "LockName"
  attribute {
    name = "LockName"
    type = "S"
  }
  tags = local.tags_common
}

//resource "aws_dynamodb_table_item" "initial_lock_count" {
//  table_name = aws_dynamodb_table.sf_execution_lock_table.name
//  hash_key = aws_dynamodb_table.sf_execution_lock_table.hash_key
//  item = <<ITEM
//{
//  "LockName": {"S": ${aws_sfn_state_machine.main_task_step_function.arn}},
//  "CurrentLockCount": {"N": "0"}
//}
//ITEM
//}
