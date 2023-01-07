variable "db_name" {
    type= string

}
variable "db_engine" {
    type= string

}
variable "db_engine_version" {
    type= string

}
variable "db-instance_class" {
  type= string
  
}
variable "db-username" {
  type= string
  
}
variable "db-password" {
  type= string
}
variable "db-allocated_storage" {
  type= number
}
variable "db-publicly_accessible" {
  type= bool
}
variable "db-port" {
  type= number
}
variable "db-storage_type" {
    type= string

}
variable "privSub1Id" {
    type= string

}
variable "privSub2Id" {
    type= string

}
variable "vpc_id"{
  type= string
}