# resource "aws_cloudwatch_event_rule" "vpc_monitoring_rule" {
#   name                = var.MONITORING_LAMBDA_RUN_FREQUENCY_RULE_NAME
#   schedule_expression = var.MONITORING_LAMBDA_RUN_FREQUENCY
# }

# resource "aws_cloudwatch_event_target" "lambda_target" {
#   rule      = aws_cloudwatch_event_rule.vpc_monitoring_rule.name
#   arn       = aws_lambda_function.vpc_logs_monitoring_lambda.arn
# }

# resource "aws_lambda_permission" "allow_eventbridge_invoke" {
#   action        = var.EVENTBRIDGE_ACTION_TO_INVOKE_LAMBDA
#   principal     = var.EVENTBRIDGE_PRINCIPAL_URL
#   function_name = aws_lambda_function.vpc_logs_monitoring_lambda.function_name
#   source_arn    = aws_cloudwatch_event_rule.vpc_monitoring_rule.arn
# }