resource "aws_launch_configuration" "ec2LaunchConfig" {
  name = "LanuchConfig- " 
  image_id      = var.AmiID
  instance_type = var.InstanceType
  security_groups=[ aws_security_group.ec2SecurityGrp.id]
  key_name = var.keyPair

 
}
resource "aws_security_group" "ec2SecurityGrp" {

  vpc_id      = var.vpc_id

  ingress {
   
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
   ingress {
   
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  tags = {
    Name = "${var.enviromentName} -ec2-sec-grp"
  }
}