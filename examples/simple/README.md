# Simple ASG example

Configuration in this directory creates the following Resources:
- An AutoScaling Group
- A Launch Configuration attached to Autoscaling Group
- IAM Instance Profile to be attached to underlying Instances.
- Security Group for Instance

You can choose to create a ASG setup with the following options:

- Create an ASG setup in an existing VPC:
    ```
        create_vpc = false          # Default setup
    ```
- Create an ASG setup in a new VPC: 
    This creates a new VPC in your account and then provisions RDS resources inside that VPC.
    ```
        create_vpc = true
    ```

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.
