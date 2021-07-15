# Create a VPC
module "vpc" {
  count        = var.create_vpc ? 1 : 0
  source       = "git@github.com:nclouds/terraform-aws-vpc.git?ref=v0.1.0"
  multi_nat_gw = false
  vpc_settings = {
    application_subnets = ["10.10.16.0/22", "10.10.20.0/22"]
    public_subnets      = ["10.10.0.0/22", "10.10.4.0/22"]
    dns_hostnames       = true
    data_subnets        = []
    dns_support         = true
    tenancy             = "default"
    cidr                = "10.10.0.0/16"
  }
  identifier = "${var.identifier}_vpc"
  region     = "us-east-1"
  tags = {
    Owner = "sysops"
    env   = "dev"
  }
}

# Create an ASG
module "asg" {
  source               = "../.."
  iam_instance_profile = "arn:aws:iam::695292474035:instance-profile/ec2-admin"
  user_data_base64     = base64encode(local.instance_userdata)
  security_groups      = [module.security_group.output.security_group.id]
  identifier           = var.identifier
  image_id             = data.aws_ssm_parameter.ec2_ami.value
  instance_type        = "t3a.medium"
  key_name             = "nclouds-tf"
  volume_size          = 30
  subnets              = var.create_vpc ? module.vpc[0].output.application_subnets.*.id : ["subnet-06c99ae7139b4c163", "subnet-00718264f27e680ca"]
  tags                 = var.tags
}
