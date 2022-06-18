module "vpc" {
  source         = "git::https://github.com/raghudevopsb64/tf-module-vpc.git"
  VPC_CIDR_BLOCK = var.VPC_CIDR_BLOCK
  COMPONENT      = var.COMPONENT
  ENV            = var.ENV
  SUBNET_CIDR    = var.SUBNET_CIDR
  AZ             = var.AZ
}

module "rabbitmq" {
  source         = "git::https://github.com/raghudevopsb64/tf-module-rabbitmq.git"
  COMPONENT      = "rabbitmq"
  ENV            = var.ENV
  VPC_ID         = module.vpc.VPC_ID
  VPC_CIDR       = module.vpc.VPC_CIDR
  SUBNET_IDS     = module.vpc.SUBNET_IDS
  NODE_TYPE      = var.NODE_TYPE
  WORKSTATION_IP = var.WORKSTATION_IP
}

module "app" {
  depends_on              = [module.vpc]
  source                  = "git::https://github.com/raghudevopsb64/tf-modfule-mutable.git"
  ONDEMAND_INSTANCE_COUNT = var.ONDEMAND_INSTANCE_COUNT
  SPOT_INSTANCE_COUNT     = var.SPOT_INSTANCE_COUNT
  VPC_ID                  = module.vpc.VPC_ID
  VPC_CIDR                = module.vpc.VPC_CIDR
  SUBNET_IDS              = module.vpc.SUBNET_IDS
  COMPONENT               = var.COMPONENT
  ENV                     = var.ENV
  NODE_TYPE               = var.EC2_NODE_TYPE
  PORT                    = var.PORT
  WORKSTATION_IP          = var.WORKSTATION_IP
  IAM_POLICY_CREATE       = true
  VPC_ACCESS_TO_ALB       = [module.vpc.VPC_CIDR, "10.10.5.0/24", "${module.vpc.NGW_PRIVATE_IP}/32"]
  PRIVATE_HOSTED_ZONE_ID  = module.vpc.PRIVATE_HOSTED_ZONE_ID
}