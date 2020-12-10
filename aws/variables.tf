variable "aws_access_key" {
  description = "AWS Access Key."
}

variable "aws_secret_key" {
  description = "AWS Secret Key."
}

variable "aws_region" {
  description = "Region to be used for deployment."
  default     = "us-west-1"
}

variable "aws_instance_type" {
  description = "The type of instance to use as the Cloud Cluster nodes."
  default     = "m5.4xlarge"
}

variable "aws_disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false
}

variable "aws_vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate with the Cloud Cluster."
}

variable "aws_subnet_id" {
  description = "The VPC Subnet ID to launch the Cloud Cluster in."
}

variable "number_of_nodes" {
  description = "The total number of nodes in the Cloud Cluster."
  default     = 4
}

variable "cluster_disk_size" {
  description = "The size of each the three data disks in each node."
  default     = "1024"
}

variable "cluster_name" {
  description = "Unique name to assign to the Rubrik cluster. This will also be used to populate the EC2 instance name tag. For example, rubrik-cloud-cluster-1, rubrik-cloud-cluster-2 etc."
  default     = "aws-cc-test"
}

# Everything below required if ever going to automate bootstrap 
variable "admin_email" {
  description = "The Rubrik cluster sends messages for the admin account to this email address."
}

variable "admin_password" {
  description = "Password for the Cloud Cluster admin account."
  default     = "YourComplicatedPassword"
}

variable "dns_search_domain" {
  type        = list(string)
  description = "List of search domains that the DNS Service will use to resolve hostnames that are not fully qualified."
  default     = ["rubrik.com"]
}

variable "dns_name_servers" {
  type        = list(string)
  description = "List of the IPv4 addresses of the DNS servers."
  default     = ["8.8.8.8"]
}

variable "ntp_servers" {
  description = "List of FQDN or IPv4 addresses of a network time protocol (NTP) server(s)"
  default     = ["169.254.169.123"]
}

variable "timeout" {
  description = "The number of seconds to wait to establish a connection the Rubrik cluster before returning a timeout error."
  default     = 15
}
