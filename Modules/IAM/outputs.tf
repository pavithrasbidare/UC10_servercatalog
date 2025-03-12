output "launch_role_arn" {
  description = "The ARN of the launch role"
  value       = aws_iam_role.launch_role.arn
}

output "launch_role_policy_arn" {
  description = "The ARN of the policy attached to the launch role"
  value       = aws_iam_policy.ec2_servicecatalog_policy.arn
}
