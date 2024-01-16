variable "region" {
  type        = string
  description = "Region in which lambda function and bcuket will be created."
  default     = "eu-north-1"
}

variable "lambda_function_name" {
  type        = string
  description = "The name of  Lambda Function."
  default     = "s3-trigger-lambda"
}

variable "handler" {
  type        = string
  description = "The Lambda function handler."
  default     = "lambda_function.lambda_handler"
}

variable "runtime" {
  type        = string
  description = "The Lambda function runtime."
  default     = "python3.11"
}

variable "trigger_events" {
  description = "List of S3 trigger events."
  default     = ["s3:ObjectCreated:*"]
}

variable "filter_prefix" {
  type        = string
  description = "Prefix filter for S3 events."
  default     = ""
}

variable "filter_suffix" {
  type        = string
  description = "Suffix filter for S3 events."
  default     = ".json"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket to trigger lambda function when a json file is created"
  default     = "s3-trigger-lambda-function-test12345"
}
