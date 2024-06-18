output "aws_log_bucket_name" {
  description = "S3 Bucket name for LB access logs"
  value       = aws_s3_bucket.this.bucket
}
