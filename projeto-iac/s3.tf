resource "aws_s3_bucket" "s3_bucket" {
  bucket = "dengue-forecast-app-frontend"

  tags = {
    gerenciado-por = "terraform"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption_configuration" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}