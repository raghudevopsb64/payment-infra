VPC_CIDR_BLOCK = "10.20.3.0/24"
ENV            = "prod"
SUBNET_CIDR    = ["10.20.3.0/25", "10.20.3.128/25"]

NODE_TYPE = "t3.micro"

EC2_NODE_TYPE           = "t3.micro"
PORT                    = 8080
ONDEMAND_INSTANCE_COUNT = 0
SPOT_INSTANCE_COUNT     = 2