{
    "Version": "2008-10-17",
    "Statement": [{
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${cloudfront_id}"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${bucket}/*"
    }]
}