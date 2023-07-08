# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "tosin-terraform-remote-state"
    key            = "expressjapa-ecs/terraform.tfstate" # indicates that the path, state file will be stored on s3 
    region         = "us-east-1"
    profile        = "terraform-user"
    dynamodb_table = "terraform-state-lock"
  }
}