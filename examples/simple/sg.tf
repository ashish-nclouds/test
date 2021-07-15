# Create a Security Group
module "security_group" {
  source     = "git@github.com:nclouds/terraform-aws-security-group.git?ref=v0.1.0"
  identifier = "${var.identifier}-sg"
  vpc_id     = var.create_vpc ? module.vpc[0].output.vpc.id : "vpc-000fe2b5ddba6bb64"
  tags       = var.tags
}