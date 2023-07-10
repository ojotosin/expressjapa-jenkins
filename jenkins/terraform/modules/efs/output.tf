# export the efs dns name
output "efs_dns_name" {
  value = aws_efs_file_system.jenkins.dns_name
}