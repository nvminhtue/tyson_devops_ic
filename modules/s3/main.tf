resource "aws_s3_bucket" "this" {
  bucket        = "${var.namespace}-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"

  depends_on = [aws_s3_bucket_ownership_controls.this]
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    id = "expired_objects"

    expiration {
      days = local.expiration_in_days
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "allow_alb_logs" {
  bucket = aws_s3_bucket.this.id
  policy = jsonencode(local.aws_s3_bucket_policy)
}
