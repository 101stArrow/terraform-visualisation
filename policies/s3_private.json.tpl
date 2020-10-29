{
    "Version": "2008-10-17",
    "Statement": [{
      "Sid": "AllowCloudfrontRead",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam:::cloudfront:user/*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${bucket}/*"
    }]
}