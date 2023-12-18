resource "aws_cloudwatch_log_group" "app_log_group" {
  name = "application_logs"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}
