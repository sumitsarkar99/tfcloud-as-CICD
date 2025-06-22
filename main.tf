module "networking" {
  source = "./networking"
}

module "security" {
  source = "./security"
  vpc_id = module.networking.vpc_id
}

module "elb" {
  source = "./elb"
  vpc_id = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
}

module "ec2" {
  source = "./ec2"
  private_subnet_ids = module.networking.private_subnet_ids
  target_group_arn   = module.elb.target_group_arn
  key_name           = var.key_name
  vpc_id             = module.networking.vpc_id
}
