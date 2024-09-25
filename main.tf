#ami
data "aws_ami" "name" {
  most_recent = true
  owners      = ["amazon"]
}
output "ami-name" {
  value = data.aws_ami.name.id
}
#security groups
data "aws_security_group" "name" {
  tags = {
    Name = "nginx-sg"
  }
}
output "sg" {
  value = data.aws_security_group.name.id
}
#VPC
data "aws_vpc" "name" {
  tags = {
    Name = "my_vpc"
  }
}
output "vpc-ou" {
  value = data.aws_vpc.name.id
}

#availability zones
data "aws_availability_zones" "name" {
  state = "available"
}
output "zones" {
  value = data.aws_availability_zones.name
}
#To get the account details
data "aws_caller_identity" "name" {
}
data "aws_region" "name" {
}
output "region_name" {
  value = data.aws_region.name
}
output "caller_info" {
  value = data.aws_caller_identity.name.account_id
}
output "caller_info_user" {
  value = data.aws_caller_identity.name.user_id
}
#subnet ID
data "aws_subnet" "name" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.name.id]

  }
  tags = {
    Name = "public-subnet"
  }
}
#create an Instance

resource "aws_instance" "myserver" {
  ami             = "ami-08718895af4dfa033"
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.name.id]
  tags = {
    Name = "Server"
  }
}
