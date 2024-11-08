# Environment variables
region       = "us-east-1"
project_name = "expressjapa"
environment  = "dev"

#vpc variables
dev_vpc_cidr               = "10.0.0.0/16"
public_subnetAZ1_cidr      = "10.0.0.0/24"
public_subnetAZ2_cidr      = "10.0.1.0/24"
public_rtb_cidr            = "0.0.0.0/0"
private_appsubnetAZ1_cidr  = "10.0.2.0/24"
private_appsubnetAZ2_cidr  = "10.0.3.0/24"
private_datasubnetAZ1_cidr = "10.0.4.0/24"
private_datasubnetAZ2_cidr = "10.0.5.0/24"


# security group variables
ssh_location = "73.103.144.223/32"


# rds variables
database_snapshot_identifier = "expressjapadb-v1-snapshot"
database_instance_class      = "db.t3.micro"
database_instance_identifier = "expressjapadb-v1new"
multi_az_deployment          = false


# sns topic variables
operator_email = "ojotosin1900@gmail.com"


# amazon certificate manager variables
domain_name       = "expressjapa.com"
alternative_names = "*.expressjapa.com"


# s3 variables
env_file_bucket_name = "travelfresh-ecs-env-file-bucket"
env_file_name        = "expressjapa.env"

# ecs variables
architecture    = "X86_64"                                                          // cpu architecture the docker image was built on
container_image = "774443160673.dkr.ecr.us-east-1.amazonaws.com/expressjapa:latest" // image uri from your ecr


# route53 variables
record_name = "www"
