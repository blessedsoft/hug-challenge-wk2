output "db_endpoint" {
  value = aws_db_instance.db.address
}

output "db_name" {
  value = aws_db_instance.db.db_name
}

output "db_username" {
  value     = aws_db_instance.db.username
  sensitive = true
}
