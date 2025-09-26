# IAM Role for Private EC2
resource "aws_iam_role" "private_ec2_role" {
  name = "private-ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy: only allow access to this S3 bucket
resource "aws_iam_policy" "s3_bucket_policy" {
  name        = "s3-private-bucket-policy"
  description = "Allow private EC2 to access specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.private_bucket.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.private_bucket.arn}/*"
        ]
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "private_ec2_role_attach" {
  role       = aws_iam_role.private_ec2_role.name
  policy_arn = aws_iam_policy.s3_bucket_policy.arn
}

# Instance Profile (for EC2 to assume the role)
resource "aws_iam_instance_profile" "private_ec2_profile" {
  name = "private-ec2-instance-profile"
  role = aws_iam_role.private_ec2_role.name
}
