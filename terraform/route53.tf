resource "aws_route53_record" "api-lb-record" {
  zone_id = data.aws_route53_zone.api-zone.zone_id
  name    = "api"
  type    = "A"

  alias {
      name                   = aws_lb.api_alb.dns_name
      zone_id                = aws_lb.api_alb.zone_id
      evaluate_target_health = true
  }
}