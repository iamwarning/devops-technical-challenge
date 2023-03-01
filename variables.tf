variable "project_name" {
  description = "Project name"
  type = string
  default = "Pulpo-DevOps"
}
# For secrets it is recommended to use environment variables or a configuration credentials manager.
## export aws_account_id=""
variable "aws_account_id" {
  description = "Master AWS account"
  type = string
  default = ""
}

## export aws_access_key=""
variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  default     = ""
}
## export aws_secret_key=""
variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  default     = ""
}
## export aws_region=""
variable "aws_region" {
  description = "Region in AWS where to create infrastructure"
  type        = string
  default     = "us-east-1"
}
## export aws_pulpo_vpc=""
variable "aws_pulpo_vpc" {
  description = "AWS VPC Id"
  type        = string
  default     = "vpc-"
}
## export public_subnets=""
variable "public_subnets" {
  description = "Public subnets where the balancer listens"
  type = list(string)
  default = [ " ", " "]
}

variable "instance_tenancy" {
  description = "Define the VPC tenancy. Whether it is default or dedicated"
  type        = string
  default     = "default"
}
## export azs=""
variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}
