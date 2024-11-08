#!/bin/bash

# Initialize and destroy resources in each Terraform directory

cd jenkins/terraform/agent
terraform init -input=false
terraform destroy --auto-approve

cd ../acm-route53
terraform init -input=false
terraform destroy --auto-approve

cd ../asg-lb
terraform init -input=false
terraform destroy --auto-approve

cd ../efs
terraform init -input=false
terraform destroy --auto-approve

cd ../iam
terraform init -input=false
terraform destroy --auto-approve

# Deregister the AMIs
aws ec2 describe-images --filters "Name=name,Values=jenkins-controller,jenkins-agent" --query 'Images[*].ImageId' --output text | tr '\t' '\n' | xargs -I {} aws ec2 deregister-image --image-id {}
