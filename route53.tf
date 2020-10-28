resource "aws_route53_record" "visualisation_domain" {
  zone_id = var.zone_id
  name    = var.domain
  type    = "CNAME"
  ttl     = "300"
  records = [aws_cloudfront_distribution.visualisation.domain_name]
}