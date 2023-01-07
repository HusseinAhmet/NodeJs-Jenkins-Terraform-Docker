output "targetGrpArns" {
  value = module.loadbalancer.targetGrpArns
}
output "LB-DNS" {
  value = module.loadbalancer.LB-DNS
}
output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.rds-redis.db_instance_endpoint
}
output "db_instance_username" {
  description = "The master username for the database"
  value       = module.rds-redis.db_instance_username
  sensitive   = true

}

output "db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = module.rds-redis.db_instance_password
  sensitive   = true
}
output "db_instance_port" {
  description = "The database port"
  value       = module.rds-redis.db_instance_port
}
output "jumpbox-pubID" {
  value= module.jumpbox.jumpbox-pubID
}
output "vpc-id" {
  value = module.vpc.vpc-id
}
output "priv-sub-1-id" {
  value = module.subnets.priv-sub-1-id
}
output "priv-sub-2-id" {
  value = module.subnets.priv-sub-2-id
}