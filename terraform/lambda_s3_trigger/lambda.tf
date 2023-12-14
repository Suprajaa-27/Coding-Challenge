# Resource to create a lambda function

resource "aws_lambda_function" "s3_trigger_lambda" {
  function_name = var.lambda_function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = var.role_arn
  filename      = var.filename
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
  source_dir  = "${path.module}/${var.lambda_source_dir}"
  output_path = "${path.module}/${var.lambda_output_path}"
}

