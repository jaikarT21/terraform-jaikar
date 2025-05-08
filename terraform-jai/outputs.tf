
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.lt.id
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.asg.name
}

output "nlb_dns_name" {
  description = "DNS name of the Network Load Balancer"
  value       = aws_lb.nlb.dns_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.tf-s3.bucket
}
