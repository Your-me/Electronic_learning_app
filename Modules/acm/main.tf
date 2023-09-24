# request public certificates from the amazon certificate manager.
  data "aws_route53_zone" "elearning_hosted_zone" {
  name         = var.domain_name
  private_zone = false
  }

resource "aws_acm_certificate" "elearning_acm_cert" {
  domain_name       = var.domain_name
  subject_alternative_names = [var.alternative_name]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy=true
}
}

# create a record set in route 53 for domain validatation
resource "aws_route53_record" "elearning_cert_dns" {
  for_each = {
    for dvo in aws_acm_certificate.elearning_acm_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.elearning_hosted_zone.zone_id
}


resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  timeouts {
    create = "5m"
  }
  certificate_arn         = aws_acm_certificate.elearning_acm_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.elearning_cert_dns : record.fqdn]
  }

resource "aws_route53_record" "domain_record" {
  zone_id = data.aws_route53_zone.elearning_hosted_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                    = var.alb-hostname
    zone_id                 = var.alb-zone_id
    evaluate_target_health  = true
  }
}