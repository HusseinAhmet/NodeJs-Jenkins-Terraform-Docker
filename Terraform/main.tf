provider "aws" {
  region  = "eu-west-3"
}

terraform {
  backend "s3" {
    bucket = "nodeapp-terraform-state-file1"
    key    = "terraform.tfstate"
    region = "eu-west-3"
  }
}
module "vpc" {
  source = "./Network/vpc/"

  cidr = "10.0.0.0/16"
  enviromentName= " NodeApp- "
}
module "subnets" {
  source = "./Network/subnets/"

  vpc_id=module.vpc.vpc-id
  enviromentName= " NodeApp- "
  PubSub1 = "10.0.1.0/24"
  PubSub2 = "10.0.3.0/24"
  PrivSub2 = "10.0.2.0/24"
  PrivSub1 = "10.0.0.0/24"
  
}
module "internet-nat-gateways" {
    source = "./Network/internet-nat-gateways/"

    vpc_id=module.vpc.vpc-id
    enviromentName= " NodeApp- "
    pubSub1ID=module.subnets.pub-sub-1-id
    pubSub2ID=module.subnets.pub-sub-2-id

}
module "route-tables" {
    source = "./Network/route-tables/"

    vpc_id=module.vpc.vpc-id
    enviromentName= " NodeApp- "
    pubSub1ID=module.subnets.pub-sub-1-id
    pubSub2ID=module.subnets.pub-sub-2-id
    Nat1ID=module.internet-nat-gateways.nat1-id
    Nat2ID=module.internet-nat-gateways.nat2-id
    IgwId=module.internet-nat-gateways.igw-id
    privSub1Id=module.subnets.priv-sub-1-id
    privSub2Id=module.subnets.priv-sub-2-id

}
module "ec2_servers" {
    source = "./Servers/ec2_servers/"

     vpc_id=module.vpc.vpc-id
     InstanceType="t2.micro"
     AmiID= "ami-03c476a1ca8e3ebdc"
     keyPair= "train-key"
     enviromentName= " NodeApp- "

}
module "jumpbox" {
    source = "./Servers/jumpbox/"
  
     vpc_id=module.vpc.vpc-id
     InstanceType="t2.micro"
     AmiID= "ami-03c476a1ca8e3ebdc"
     keyPair= "train-key"
     enviromentName= " NodeApp- "
     pubSub1ID=module.subnets.pub-sub-1-id
}
module "ASG" {
      source = "./Servers/auto-scalling-group/"

      CPUPolicyTargetValue=40.0
      MinCapacity="2"
      MaxCapacity="4"
      privSub1Id=module.subnets.priv-sub-1-id
      privSub2Id=module.subnets.priv-sub-2-id
      launch-config-name=module.ec2_servers.LaunchConfigName
      target-group-arns=module.loadbalancer.targetGrpArns

}
module "rds-redis" {
  source = "./Servers/rds-redis/"

  vpc_id=module.vpc.vpc-id
  db_name="mydb"
  db_engine="mysql"
  db_engine_version="5.7.11"
  db-instance_class="db.t2.micro"
  db-username="admin"
  db-password="12345678"
  db-publicly_accessible=false
  db-port=3306
  db-storage_type="gp2"
  db-allocated_storage=20
  privSub1Id=module.subnets.priv-sub-1-id
  privSub2Id=module.subnets.priv-sub-2-id

}
module "loadbalancer" {
  source = "./Servers/loadbalancer/"

   enviromentName= " NodeApp- "
   pubSub1ID=module.subnets.pub-sub-1-id
   pubSub2ID=module.subnets.pub-sub-2-id
   lb-port =3000
   vpc_id=module.vpc.vpc-id
}
