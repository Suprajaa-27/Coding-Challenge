# Define an IAM role for the Lambda function
resource "aws_iam_role" "aws_lambda_role" {
  name = "aws-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# REVIEW: Scope the access down to a specific log group used by Lambda. 
# IAM Policy for cloud watch logs
resource "aws_iam_policy" "cloud_watch_iam_policy" {

  name        = "aws_iam_policy_for_cloud_watch"
  path        = "/"
  description = "AWS IAM Policy for cloud watch"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Policy Attachment to the role.

resource "aws_iam_role_policy_attachment" "attach_cloud_watch_policy_to_lambda_role" {
  role       = aws_iam_role.aws_lambda_role.name
  policy_arn = aws_iam_policy.cloud_watch_iam_policy.arn
}

# REVIEW: Remove "s3:PutObject" as it is not necessary for Lambda in this assignment. 
# Policy that allow lambda to access s3.
resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  description = "Policy for Lambda function to access S3"

  # Define the policy document with appropriate permissions for S3 access
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.s3_bucket.arn}",
        "${aws_s3_bucket.s3_bucket.arn}/*"
      ]
    }
  ]
}
EOF
}

# S3 Policy attachment to Lambda role.
resource "aws_iam_role_policy_attachment" "lambda_s3_policy_attachment" {
  role       = aws_iam_role.aws_lambda_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# AWS Lambda permission to allow S3 to invoke it.
resource "aws_lambda_permission" "s3_trigger_permission" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_trigger_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.s3_bucket.arn
}

