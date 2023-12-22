resource "aws_cloudwatch_log_group" "app_log" {
  name              = "lambda_log"
  retention_in_days = 5
  lifecycle {
    prevent_destroy = false
  }
}
