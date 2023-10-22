output "intuitive_vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.intuitiveVPC.id
}

output "intuitive_public_subnets" {
  description = "Will be used by Web Server Module to set subnet_ids"
  value = [
    aws_subnet.intuitivePublicSubnet1,
    aws_subnet.intuitivePublicSubnet2
  ]
}

output "intuitive_private_subnets" {
  description = "Will be used by RDS Module to set subnet_ids"
  value = [
    aws_subnet.intuitivePrivateSubnet1,
    aws_subnet.intuitivePrivateSubnet2
  ]
}