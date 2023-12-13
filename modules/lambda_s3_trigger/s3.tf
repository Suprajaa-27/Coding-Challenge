# Creating s3 bucket
resource "aws_s3_bucket" "s3_bucket" {

  bucket = var.bucket_name
}
resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {

  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    id = "object-lifecycle-rule"

    expiration {
      days = 90
    }
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_versioning" "object-versioning" {

  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_object_lock_configuration" "object-lock" {

  bucket              = aws_s3_bucket.s3_bucket.id
  object_lock_enabled = "Enabled"

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 5
    }
  }
}
