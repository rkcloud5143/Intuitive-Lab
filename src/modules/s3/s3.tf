# S3 Bucket for TF State File
resource "aws_s3_bucket" "intuitive" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    owner = "intuitive-cloud"
  }
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.intuitive.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "intuitive_crypto_conf" {
  bucket = aws_s3_bucket.intuitive.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}