locals {
  vpc_name = "${var.namespace}-vpc"

  azs = [
    "ap-southeast-1a",
    "ap-southeast-1b",
  ]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
  public_subnets = [
    "10.0.3.0/24",
    "10.0.4.0/24",
  ]

  # Single NAT Gateway scenario
  # all private subnets will route their Internet traffic through this single NAT gateway.
  # The NAT gateway will be placed in the first public subnet in the public_subnets block.

  # provision NAT Gateways for each of private networks
  enable_nat_gateway     = true

  # provision a single shared NAT Gateway across all of private networks
  single_nat_gateway     = true

  # Do NOT allow only one NAT Gateway per availability zone
  one_nat_gateway_per_az = false

  # enable DNS hostnames in the VPC
  enable_dns_hostnames   = true
}
