variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}


variable "web_sg_id" {
  type = string
}

variable "ami_id" {
  type    = string
  default = "ami-00ca32bbc84273381"
}

variable "instance_type" {
  type  = string
  default = "t2.micro"
}

variable "asg_desired_capacity" {
  type    = number
  default = 1
}

variable "asg_min_size" {
  type    = number
  default = 1
}

variable "asg_max_size" {
  type    = number
  default = 2
}
