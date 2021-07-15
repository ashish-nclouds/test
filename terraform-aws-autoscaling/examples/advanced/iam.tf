# Create an IAM Role
module "example_role" {
  source                 = "git@github.com:nclouds/terraform-aws-iam-role.git?ref=v0.1.0"
  description            = "Example IAM Role"
  iam_policies_to_attach = []
  aws_service_principal  = "ec2.amazonaws.com"
  identifier             = "${var.identifier}-role"
  tags                   = var.tags
}