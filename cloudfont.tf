resource "aws_cloudfront_origin_access_identity" "visualisation" {
  comment = var.id
}

resource "aws_cloudfront_distribution" "visualisation" {
  origin_group {
    origin_id = "groupS3-${var.id}"
    failover_criteria {
      status_codes = [403, 404, 500, 502]
    }
    member {
      origin_id = "primaryS3-${var. id}"
    }
    member {
      origin_id = "failoverS3-${var.id}"
    }
  }
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_domain_name
    origin_id   = "primaryS3-${var.id}"
  }
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_domain_name
    origin_id   = "failoverS3-${var.id}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  web_acl_id          = aws_waf_web_acl.waf_acl.id
  aliases = [var.domain]
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "groupS3-${var.id}"
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  price_class = "PriceClass_200"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Project  = "franscape"
    Instance = var.id
    Type     = "visualisation"
  }

  viewer_certificate {
    ssl_support_method = "sni-only"
    acm_certificate_arn = var.cloudfront_cert_arn
  }
  wait_for_deployment = true
}