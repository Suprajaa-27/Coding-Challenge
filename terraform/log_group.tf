# resource "aws_cloudwatch_log_group" "app_log_group" {
#   name = "/aws/lambda/${var.lambda_function_name}"
#   retention_in_days = 1
#   lifecycle {
#     prevent_destroy = false
#   }
# }
