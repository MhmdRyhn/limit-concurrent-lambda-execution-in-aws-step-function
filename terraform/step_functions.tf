data "template_file" "main_task_step_function_definition" {
  template = file("${path.module}/step_function_definitions/acquire_lock_sf.json")
  # TODO: add all the vars used in the template
  vars = {}
}

resource "aws_sfn_state_machine" "main_task_step_function" {
  name       = "${local.prefix}-throlling-opration-workflow-sf"
  definition = data.template_file.main_task_step_function_definition.rendered
  role_arn   = ""
  tags       = local.tags_common
}

data "template_file" "release_lock_step_function_definition" {
  template = file("${path.module}/step_function_definitions/release_lock_sf.json")
  # TODO: add all the vars used in the template
  vars = {}
}

resource "aws_sfn_state_machine" "release_lock_step_function" {
  name       = "${local.prefix}-release-lock-workflow-sf"
  definition = data.template_file.release_lock_step_function_definition.rendered
  role_arn   = ""
  tags = local.tags_common
}
