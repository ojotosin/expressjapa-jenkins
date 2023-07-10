provider "aws" {
  region = "us-west-2"
}

module "asg-lb" {
  source        = "../modules/asg-lb"
  subnets       = ["subnet-0b01d37d289c7fd1d", "subnet-01395b76a07ba911b", "subnet-01e4aa3186984261c"]
  ami_id        = "ami-0db34be85e823b8e2"
  instance_type = "t2.small"
  key_name      = "my-us-west-keypair"
  environment   = "dev"
  vpc_id        = "vpc-0c1daa67fb89fb29f"
  ssl_certificate_arn = "arn:aws:acm:us-west-2:774443160673:certificate/0f8ea47b-c885-4e47-b08f-1ccc997cd9e6"
}