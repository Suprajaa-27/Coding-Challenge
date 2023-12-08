variable "region" {
  type        = string
  description = "Region in which lambda function and bcuket will be created."
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda Function."
}

variable "handler" {
  type        = string
  description = "The Lambda function handler."
}

variable "runtime" {
  type        = string
  description = "The Lambda function runtime."
}

variable "role_arn" {
  type        = string
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

}

variable "s3_bucket_id" {
  type        = string
  description = "S3 bucket id to trigger lambda function when a json file is created"
}

variable "lambda_source_dir" {
  description = "Source directory for Lambda function code"
  type        = string
  default     = "../../src"

}

variable "lambda_output_path" {
  description = "Output path for the Lambda function zip file"
  type        = string
  default     = "../../lambda_function.zip"
}