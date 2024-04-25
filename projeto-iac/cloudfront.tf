data "aws_cloudfront_cache_policy" "cloudfront_cache_policy" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_origin_access_control" "origin_access_control" {
  name                              = "s3-origin-access"
  description                       = "conexao-bucket-s3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.origin_access_control.id
    origin_id                = aws_s3_bucket.s3_bucket.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Distribuição cloudfront para a aplicação front-end"
  default_root_object = "teste1.html"

  #   aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.s3_bucket.id
    cache_policy_id        = data.aws_cloudfront_cache_policy.cloudfront_cache_policy.id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["BR"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    gerenciado-por = "terraform"
  }
}