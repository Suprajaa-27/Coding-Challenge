output "s3_bucket_id" {
  description = "The ID of s3 bucket."
  value       = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_arn" {
  description = "The arn of s3 bucket."
  value       = aws_s3_bucket.s3_bucket.arn
}

output "lambda_role_arn" {
  description = "The arn of lambda role"
  value       = aws_iam_role.aws_lambda_iam_role.arn
}
