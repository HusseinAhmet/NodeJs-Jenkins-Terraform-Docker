resource "aws_internet_gateway" "Igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.enviromentName} InternetGateway"
  }
}
resource "aws_eip" "EIP1" {

  vpc      = true
}
resource "aws_eip" "EIP2" {
  vpc      = true
}
resource "aws_nat_gateway" "Nat1" {
  allocation_id = aws_eip.EIP1.id
  subnet_id     = var.pubSub1ID

  tags = {
    Name = "gw NAT1"
  }
}
resource "aws_nat_gateway" "Nat2" {
  allocation_id = aws_eip.EIP2.id
  subnet_id     = var.pubSub2ID

  tags = {
    Name = "gw NAT2"
  }

}
