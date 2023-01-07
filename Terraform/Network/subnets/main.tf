data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "PubSub1" {
  vpc_id     =var.vpc_id
  cidr_block = var.PubSub1
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.enviromentName} PublicSubnet1"
  }
}
resource "aws_subnet" "PrivSub1" {
  vpc_id     =var.vpc_id
  cidr_block = var.PrivSub1
availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.enviromentName} PrivateSubnet1"
  }
}
resource "aws_subnet" "PubSub2" {
  vpc_id     =var.vpc_id
  cidr_block = var.PubSub2
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.enviromentName} PublicSubnet2"
  }
}
resource "aws_subnet" "PrivSub2" {
  vpc_id     =var.vpc_id
  cidr_block = var.PrivSub2
availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "${var.enviromentName} PrivateSubnet2"
  }
}