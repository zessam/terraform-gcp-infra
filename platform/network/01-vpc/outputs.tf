# output "public_subnets_ips" {
#   value = module.vpc.subnets_ips[1]
# }
output "private_subnets_ips" {
  value = module.vpc.subnets_ips[0]
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "private_subnets_names" {
  #value       = [for network in module.subnets.subnets : network.name]
  value       = module.vpc.subnets_names[0]
  description = "The names of the subnets being created"
}

output "private_secondary_ranges" {
  value       = module.vpc.subnets_secondary_ranges[0]
  description = "The names of the subnets being created"
}

output "secondary_ranges" {
  value       = module.vpc.subnets_secondary_ranges
  description = "The names of the subnets being created"
}

output "first_private_range_name" {
  value       = module.vpc.subnets_secondary_ranges[0][0]["range_name"]
  description = "The name of the first private secondary range"
}
output "second_private_range_name" {
  value       = module.vpc.subnets_secondary_ranges[0][1]["range_name"]
  description = "The name of the first private secondary range"
}
output "network_id" {
  value = module.vpc.network_id
}