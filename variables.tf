variable "id" {
  type        = string
  description = "Lower case word to identify the visualisation"
}

variable "domain" {
  type        = string
  description = "The domain name to host the visualisation"
}

variable "certificate_arn" {
  type        = string
  description = "The ACM certificate ARN for SSL"
}

variable "cloudfront_cert_arn" {
  type        = string
  description = "The ACM certificate ARN for SSL on cloudfront"
}

variable "zone_id" {
  type        = string
  description = "The Route53 zone id for the DNS resources"
}

variable "ip_whitelist" {
  type        = list(string)
  description = "A list of IPs to allow through the firewall"
  default     = list("95.146.225.164", "86.25.34.88", "159.242.113.194")
}