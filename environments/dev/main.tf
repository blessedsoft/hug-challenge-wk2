provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source = "../../modules/networking"
}

module "compute" {
  source               = "../../modules/compute"
  vpc_id               = module.networking.vpc_id
  public_subnets       = module.networking.public_subnets
  private_subnets      = module.networking.private_subnets
  web_sg_id            = module.networking.web_sg_id
  asg_desired_capacity = var.asg_desired_capacity
  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
}

module "database" {
  source          = "../../modules/database"
  private_subnets = module.networking.private_subnets
  db_sg_id        = module.networking.db_sg_id
  db_username     = var.db_username
  db_password     = var.db_password
}