variable "private_subnets" {
  type = list(string)
}

variable "db_name" {
  type = string
  default = "myTestDB"
}

variable "db_username" {
  type = string
  default = "admin"
}

variable "db_password" {
  type      = string
  default   = "ChangeMe123!"
  sensitive = true
}
variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}
variable "db_sg_id" {
  type = string
  default= "db-security-group"
}
variable "db_subnet_group" {
    type = string
    default = "db-subnet-group"
}