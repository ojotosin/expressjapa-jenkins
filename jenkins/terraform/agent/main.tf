provider "aws" {
  region = "us-west-2"
}

module "ec2_instance" {
  source = "../modules/ec2"

  instance_name      = "jenkins-agent"
  ami_id             = "ami-0b4060e6d26edd9a7"
  instance_type      = "t2.large"
  key_name           = "my-us-west-keypair"
  subnet_ids         = ["subnet-0b01d37d289c7fd1d", "subnet-01395b76a07ba911b", "subnet-01e4aa3186984261c"]
  instance_count     = 1

}