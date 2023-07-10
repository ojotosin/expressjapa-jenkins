#!/bin/bash

# launch the iam instance role 
cd terraform/iam
terraform apply --auto-approve

# launch the efs
cd ../efs
terraform apply --auto-approve


cd ../..

# Retrieve the values of the exported dns name outputs from efs
efs_dns_name=$(terraform output -raw efs_dns_name)

# build the jenkins controller ami
packer build -var "efs_mount_point=$efs_dns_name" jenkins-controller.pkr.hcl

# build the jenkins agent ami
packer build -var "public_key_path=/devops-tools/jenkins/id_rsa.pub" jenkins-agent.pkr.hcl




# launch the load balancer autoscaling group
cd terraform/asg-lb
terraform apply --auto-approve

# launch dns and enable ssl
cd ../acm-route53
terraform apply --auto-approve



