module "public_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "SG_public"
  description = "SG used in public subnets"
  vpc_id      = module.vpc.vpc_id


  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "port 22 for bastion"
      cidr_blocks = "0.0.0.0/0"
    },

  ]
  egress_rules = ["all-all"]
}

module "private_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "SG_private"
  description = "SG used in private subnets"
  vpc_id      = module.vpc.vpc_id


  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "all ports allowed for cidr block"
      cidr_blocks = module.vpc.vpc_cidr_block
    },

  ]
  egress_rules = ["all-all"]
}