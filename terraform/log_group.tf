resource "aws_cloudwatch_log_group" "app_log" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 5
  lifecycle {
    prevent_destroy = false
  }
}
