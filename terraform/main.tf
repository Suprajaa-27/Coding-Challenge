# Resource to create a lambda function

resource "aws_lambda_function" "s3_trigger_lambda" {
  function_name = var.lambda_function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = aws_iam_role.aws_lambda_role.arn
  filename      = "${path.module}/lambda_function.zip"
  depends_on = [
    aws_iam_role_policy_attachment.attach_cloud_watch_policy_to_lambda_role,
    aws_cloudwatch_log_group.app_log_group,
  ]
}

#Resource to configure Lambda as an event trigger for S3 bucket.
resource "aws_s3_bucket_notification" "s3_event_trigger" {
  bucket = aws_s3_bucket.s3_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_trigger_lambda.arn
    events              = var.trigger_events
    filter_prefix       = var.filter_prefix
    filter_suffix       = var.filter_suffix
  }
}

# To Package lambda function code
data "archive_file" "zip_python_code" {
  type        = "zip"
  source_dir = "${path.module}/../src"
  output_path = "${path.module}/lambda_function.zip"
}

