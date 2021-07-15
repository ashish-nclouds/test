# AWS Autoscaling Group (ASG) Terraform Module

Terraform module to provision [`AutoScaling Group`](https://aws.amazon.com/autoscaling/) on AWS.

## Usage

### Simple setup
Create a simple ASG with default configurations.
```hcl
    locals {
        instance_userdata = <<USERDATA
        #!/bin/sh
        yum update -y
    USERDATA
    }

    module "asg" {
        source                      = "git@github.com:nclouds/terraform-aws-autoscaling.git?ref=v0.1.1"
        iam_instance_profile        = "arn:aws:iam::xxxxxxxx:instance-profile/xxxxxx"
        user_data                   = base64encode(local.instance_userdata)
        security_groups             = ["sg-xxxxxxxxxxx"]
        identifier                  = "example"
        image_id                    = "ami-xxxxxxxx"
        instance_type               = "t3a.medium"
        key_name                    = "nclouds-tf"
        device_name                 = "/dev/xvda"
        volume_size                 = 30
        subnets                     = ["subnet-xxxxxxxxxxx", "subnet-xxxxxxxxxx"]
        tags                        = {
            Owner       = "sysops"
            env         = "dev"
            Cost_Center = "XYZ"
        }
    }
```

For more details on a working example, please visit [`examples/simple`](examples/simple)

### Advanced Setup
If you want to create ASG with enhanced configuration e.g multiple instances etc., you can use the module like this:

```hcl
    locals {
        instance_userdata = <<USERDATA
        #!/bin/sh
        yum update -y
    USERDATA
    }

    module "asg" {
        source                                  = "git@github.com:nclouds/terraform-aws-autoscaling.git?ref=v0.1.1"
        iam_instance_profile                    = "arn:aws:iam::xxxxxxxx:instance-profile/xxxxxx"
        user_data_base64                        = base64encode(local.instance_userdata)
        associate_public_ip_address             = true
        security_groups                         = ["sg-xxxxxxxxxxx"]
        identifier                              = "example"
        image_id                                = "ami-xxxxxxxx"
        instance_type                           = "t3a.medium"
        key_name                                = "nclouds-tf"
        device_name                             = "/dev/xvda"
        volume_size                             = 30
        volume_type                             = "gp2"
        ebs_optimized                           = false
        encrypted                               = true
        instance_initiated_shutdown_behavior    = "stop"
        min_size                                = 2
        max_size                                = 5
        subnets                                 = ["subnet-xxxxxxxxxxx", "subnet-xxxxxxxxxx"]
        tags                                    = {
            Owner       = "sysops"
            env         = "dev"
            Cost_Center = "XYZ"
        }
    }

```

For more options refer to a working example at [`examples/advanced`](examples/advanced)

## Examples
Here are some working examples of using this module:
- [`examples/simple`](examples/simple)
- [`examples/advanced`](examples/advanced)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template.launch_temlate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_append_workspace"></a> [append\_workspace](#input\_append\_workspace) | Appends the terraform workspace at the end of resource names, <identifier>-<worspace> | `bool` | `true` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Associate a public ip address with an instance in a VPC | `bool` | `false` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `true` | no |
| <a name="input_eks_cluster_id"></a> [eks\_cluster\_id](#input\_eks\_cluster\_id) | If set add the tag kubernetes.io/cluster/<cluster-name> = owned | `string` | `""` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | The name attribute of the IAM instance profile to associate with launched instances | `string` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | The name for the resource | `string` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | AMI to use | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 Instance type to use | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The name of the key-pair to use | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximun number of instances in the ASG | `number` | `5` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of instances in the ASG | `number` | `1` | no |
| <a name="input_protect_from_scale_in"></a> [protect\_from\_scale\_in](#input\_protect\_from\_scale\_in) | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security groups to assign to instances | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnet IDs to launch resources in | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the resource | `map(any)` | `{}` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | base64-encoded user-data | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | The size of the root ebs volume | `number` | `20` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | The type of volume. Can be 'standard', 'gp2', or 'io1' | `string` | `"gp2"` | no |
| <a name="update_default_version"></a> [update_default_version](#input\_update_default_version) | Update the Launch template version | `bool` | `true` | no |
| <a name="device_name"></a> [device_name](#input\_device_name) | The name of the device to mount | `string` | `"/dev/xvda"` | no |
| <a name="iops"></a> [iops](#input\_iops) | The amount of provisioned IOPS. This must be set with a volume_type of "io1/io2" | `number` | `"null"` | no |
| <a name="monitoring"></a> [monitoring](#input\_monitoring) | The launched EC2 instance will have detailed monitoring enabled, if its true | `bool` | `"false"` | no |
| <a name="market_type"></a> [market_type](#input\_market_type) | To allocate resource in spot / ondemand | `string` | `"null"` | no |
| <a name="credit_specification"></a> [credit_specification](#input\_credit_specification) |The credit specification of the instance standard / unlimited for T2/T3 | `string` | `"standard"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output"></a> [output](#output\_output) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing
If you want to contribute to this repository check all the guidelines specified [here](.github/CONTRIBUTING.md) before submitting a new PR.
