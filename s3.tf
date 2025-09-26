resource "aws_s3_bucket" "s3_private1" {
  bucket = "my-private-s3-bucket-demo123"   # change bucket name (must be globally unique)

  tags = {
    Name = "${var.project_name}-s3-private1"
    Managed_by = "${var.managed_by}"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "s3_block-public1" {
  bucket                  = aws_s3_bucket.private_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "private_bucket_encryption" {
  bucket = aws_s3_bucket.private_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}