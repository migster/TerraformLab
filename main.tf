resource "aws_vpc" "main_dev_vpc" {
    cidr_block = "10.55.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "MainDevVPC"
        ManagedBy = "Terraform"
    }
}