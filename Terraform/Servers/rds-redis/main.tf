resource "aws_db_instance" "rds" {
  allocated_storage    = var.db-allocated_storage
  db_name              = var.db_name
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db-instance_class
  username             = var.db-username
  password             = var.db-password
  publicly_accessible =var.db-publicly_accessible
  vpc_security_group_ids = [ "${aws_security_group.db_security_group.id}" ]
  port = var.db-port
  storage_type = var.db-storage_type
  db_subnet_group_name = aws_db_subnet_group.db_subnetGRP.name
  skip_final_snapshot= true
  
   provisioner "local-exec" {

     command = <<EOT
      echo "RDS_HOSTNAME=${self.address} " > rdsenv.txt;
      echo "RDS_USERNAME=${self.username} " >> rdsenv.txt;
      echo "RDS_PORT=${self.port} " >> rdsenv.txt;
   EOT
 }
}

resource "aws_db_subnet_group" "db_subnetGRP" {
  name       = "main"
  subnet_ids = [var.privSub1Id, var.privSub2Id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_security_group" "db_security_group" {
  name        = "db-security-group"
  description = "Security group for MySQL database"
  vpc_id= var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}