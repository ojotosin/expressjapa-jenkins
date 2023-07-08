provider "aws" {
  region = "us-west-2"
}

# request SSL certificate module
module "ssl_certificate" {
  source            = "../modules/acm"
  domain_name       = "tosin-ojo.com"
  alternative_names = "*.tosin-ojo.com"

}

# use data source to get dns names
data "aws_lb" "jenkins" {}

# request route53 module
module "route53_module" {
  source = "../modules/route53"
  domain_name       = "tosin-ojo.com"
  record_name       = "www"
  jenkins_dns_name = data.aws_lb.jenkins.dns_name
  jenkins_zone_id  = data.aws_lb.jenkins.zone_id

}
