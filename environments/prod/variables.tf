variable "db_username" {
  type    = string
}

variable "db_password" {
  type = string
}

variable "asg_desired_capacity" {
  type    = number
}

variable "asg_min_size" {
  type    = number
}

variable "asg_max_size" {
  type    = number
}
