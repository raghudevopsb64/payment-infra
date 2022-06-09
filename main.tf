module "vpc" {
  source         = "git::https://github.com/raghudevopsb64/tf-module-vpc.git"
  VPC_CIDR_BLOCK = var.VPC_CIDR_BLOCK
  COMPONENT      = var.COMPONENT
  ENV            = var.ENV
  SUBNET_CIDR    = var.SUBNET_CIDR
  AZ             = var.AZ
}

module "rabbitmq" {
  source     = "git::https://github.com/raghudevopsb64/tf-module-rabbitmq.git"
  COMPONENT  = "rabbitmq"
  ENV        = var.ENV
  VPC_ID     = module.vpc.VPC_ID
  VPC_CIDR   = module.vpc.VPC_CIDR
  SUBNET_IDS = module.vpc.SUBNET_IDS
  NODE_TYPE  = var.NODE_TYPE
}
