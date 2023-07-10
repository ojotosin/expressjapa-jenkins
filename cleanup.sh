#!/bin/bash

cd jenkins/terraform/agent
terraform destroy --auto-approve

cd ../acm-route53
terraform destroy --auto-approve

cd ../asg-lb
terraform destroy --auto-approve

cd ../efs
terraform destroy --auto-approve

cd ../iam
terraform destroy --auto-approve

# deregister the AMIs
aws ec2 describe-images --filters "Name=name,Values=jenkins-controller,jenkins-agent" --query 'Images[*].ImageId' --output text | tr '\t' '\n' | xargs -I {} aws ec2 deregister-image --image-id {}

# delete the parameter store values
#aws ssm delete-parameter --name /devops-tools/jenkins/id_rsa
#aws ssm delete-parameter --name /devops-tools/jenkins/id_rsa.pub