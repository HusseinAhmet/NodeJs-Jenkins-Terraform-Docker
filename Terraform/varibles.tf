variable "cidr" {
  type = string
}
variable "enviromentName" {
  type = string
}
variable "PubSub1" {
  type = string
}
variable "PubSub2" {
  type = string
}
variable "PrivSub1" {
   type = string
}
variable "PrivSub2" {
   type = string
}
variable "InstanceType" {
  type = string
}
variable "AmiID" {
  type = string
}
variable "CPUPolicyTargetValue" {
  type = string
}
variable "MinCapacity" {
  type = string
}
variable "MaxCapacity" {
   type = string
}
variable "keyPair" {
   type = string
}
variable "bucketname" {
  type = string
}
variable "lb-port" {
  type = number
}
variable "db_name" {
  type = string
}
variable "db-engine" {
  type = string
}
variable "db-engine-version" {
  type = string
}
variable "db-instance_class" {
  type = string
}
variable "db-username" {
  type = string
}
variable "db-password" {
  type = string
}
variable "db-publicly_accessible" {
  type = string
}
variable "db-allocated_storage" {
  type = number
}
variable "db-port" {
  type = number
}
variable "db-storage_type" {
  type = string
}