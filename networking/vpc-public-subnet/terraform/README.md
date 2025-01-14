# Terraform Instructions

### Creation
1. Install Terraform on your machine
2. Create `terraform.tfvars` file here in this folder and add following values in it.
```bash
aws_region = "ap-south-1"
key_name = "you-key-pair-name" # replace this with yours.
environment = "test"
ami_id = "ami-xxxxxxxxxxx" # add ami id here.
```
3. Run the following commands:
```bash
terraform init
terraform plan
teraform apply
```
4. Connect to the instance using the public ip. To get the public ip of the instance run the following command
```bash
terraform output -raw instance_public_ip
```
5. Once you get the public ip, try connecting to the instance using you key pair.
```bash
  ssh -i <your-key.pem> ec2-user@<instance-public-ip>
```
------

### Clean up
To delete the resources run the following command:
```bash
terraform destroy
```