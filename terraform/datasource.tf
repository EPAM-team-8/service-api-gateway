data "aws_vpc" "my-vpc"{
    filter {
    name = "tag:Name"
    values = ["my-vpc"]
  }
}

data "aws_subnet" "publicSubnet" {
  vpc_id = data.aws_vpc.my-vpc.id
  filter {
    name = "tag:Name"
    values = ["public"]
  }
}

data "aws_security_group" "sg" {
    vpc_id =  data.aws_vpc.my-vpc.id
    name = "all"
}

output "vpc" {
    value = data.aws_vpc.my-vpc.id
}
output "subnet" {
    value = data.aws_subnet.publicSubnet.id
}

output "sg" {
    value = data.aws_security_group.sg.id
}