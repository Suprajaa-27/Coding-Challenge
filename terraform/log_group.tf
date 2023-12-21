resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "lambda_app_logs"
  retention_in_days = 5
  lifecycle {
    prevent_destroy = false
  }
}
