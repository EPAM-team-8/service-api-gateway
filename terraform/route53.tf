resource "aws_route53_zone" "consul_aws" {
  name = "api.com"
vpc {
  vpc_id  = data.aws_vpc.my-vpc.id
  }
}

resource "aws_route53_record" "record" {
  zone_id = aws_route53_zone.consul_aws.zone_id
  name = "api.com"
  type = "A"
  ttl  = "300"
  records = [aws_instance.API.private_ip]
}