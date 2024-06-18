resource "aws_s3_bucket" "this" {
  bucket        = "${var.namespace}-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket
  rule {
    id = "expired_objects"

    expiration {
      days = local.expiration_in_days
    }

    status = "Enabled"
  }
}

// TODO: Add s3 bucket policy for alb
