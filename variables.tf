variable "log_group_name" {
  type = string
  default = "ramesh-log-group-vpc-new"
}

variable "iam_role_name" {
  type = string
  default = "ramesh-vpc-flowlog-role"
}

variable "region" {
  type = string
  default = "eu-west-1"
}

variable "iam_policy_name" {
  type = string
  default = "ramesh-policy"
}

variable "bucket_name" {
  type = string
  default = "ramesh-vpc-bkt"
}

variable "public_subnet_cidrs" {
  description = "Subnet CIDRs for public subnets (length must match configured availability_zones)"
  default = [
    "10.1.1.0/24", 
    "10.1.2.0/24"
    ]
  type = list
}


//Security Groups
//DHCP Option Sets
//Your VPCs
//Internet gateways
//Route tables
//Roles
//CloudWatch