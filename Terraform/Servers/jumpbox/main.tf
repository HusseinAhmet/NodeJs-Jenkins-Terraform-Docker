resource "aws_instance" "bastionServer" {  
  ami = var.AmiID
  instance_type = var.InstanceType
  subnet_id = var.pubSub1ID
  security_groups=[ aws_security_group.bastionSecGrp.id]
  key_name = var.keyPair

  tags = {
    Name = "${var.enviromentName} - Jumpbox"
  }
     provisioner "local-exec" {
   command = "echo ${self.public_ip} >> inventory.txt"
 }
}

resource "aws_security_group" "bastionSecGrp" {

  vpc_id      = var.vpc_id

  ingress {
   
    from_port        = 80
    to_port          = 80
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
}
