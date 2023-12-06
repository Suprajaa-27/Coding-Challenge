# modules/lambda_s3_trigger/variables.tf

variable "region" {
  type = string
  description = "Region in which lambda function and bcuket will be created."
}

variable "lambda_function_name" {
  type = string
  description = "The name of the Lambda Function."
}

variable "handler" {
  description = "The Lambda function handler."
}

variable "runtime" {
  description = "The Lambda function runtime."
}

variable "role_arn" {
  description = "The ARN of the IAM role for the Lambda function."
}

variable "filename" {
  description = "The path to the Lambda function deployment package (ZIP file)."
}

variable "trigger_events" {
  description = "List of S3 trigger events."
  default     = ["s3:ObjectCreated:*"]
}

variable "filter_prefix" {
  description = "Prefix filter for S3 events."
  default     = ""
}

variable "filter_suffix" {
  description = "Suffix filter for S3 events."
  default     = ".json"
}

variable "bucket_name" {
  description = "S3 bucket to trigger lambda function when a json file is created"
   
}

variable "s3_bucket_id" {
  description = "S3 bucket to trigger lambda function when a json file is created"
}
