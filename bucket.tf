data "template_file" "bucket_policy" {
  template = file("${path.module}/policies/s3_private.json.tpl")
  vars = {
    bucket = "franscape-visualisation-${var.id}",
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "franscape-visualisation-${var.id}"
  acl    = "private"
  policy = data.template_file.bucket_policy.rendered

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
