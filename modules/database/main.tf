resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "db-subnet-group"
    
  }
}

resource "aws_db_instance" "db" {
  identifier              = "webapp-db"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  db_name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [var.db_sg_id]
  skip_final_snapshot     = true
  publicly_accessible     = false
}
