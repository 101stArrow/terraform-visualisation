data "template_file" "bucket_policy" {
  template = file("${path.module}/policies/s3_private.json.tpl")
  vars = {
    bucket = "franscape-visualisation-${var.id}",
    cloudfront_id = aws_cloudfront_origin_access_identity.visualisation.id
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "franscape-visualisation-${var.id}"
  acl    = "private"

  tags = {
    Project  = "franscape"
    Instance = var.id
    Type     = "visualisation"
  }

  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

resource "aws_s3_bucket_policy" "cloudfront" {
  depends_on = [aws_s3_bucket.bucket, aws_cloudfront_distribution.visualisation]
  bucket = aws_s3_bucket.bucket.id
  policy = data.template_file.bucket_policy.rendered
}
