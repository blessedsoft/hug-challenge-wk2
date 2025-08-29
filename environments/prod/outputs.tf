output "alb_dns_name" {
  value = module.compute.alb_dns_name
}

output "db_endpoint" {
  value = module.database.db_endpoint
}

output "db_username" {
  value     = module.database.db_username
  sensitive = true
}
