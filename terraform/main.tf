# Resource to create a lambda function

resource "aws_lambda_function" "s3_trigger_lambda_function" {
  function_name = var.lambda_function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = aws_iam_role.aws_lambda_role.arn
  filename      = "${path.module}/lambda_function.zip"
  tracing_config {
    mode = "Active"
  }

  # Attach the custom log group ARN
  environment {
    variables = {
      CW_LOG_GROUP = aws_cloudwatch_log_group.app_log_group.arn
    }
  }
}
#Resource to configure Lambda as an event trigger for S3 bucket.
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.s3_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_trigger_lambda_function.arn
    events              = var.trigger_events
    filter_prefix       = var.filter_prefix
    filter_suffix       = var.filter_suffix
  }
  depends_on = [aws_lambda_permission.s3_trigger_permission]
}

# To Package lambda function code
data "archive_file" "zip_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/../src"
  output_path = "${path.module}/lambda_function.zip"
}
