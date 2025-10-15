output "zones" {
  value = data.google_compute_zones.available_zones.names
}
output "node_pools_tags" {
  value = module.gke.node_pools_tags["all"][0]
}
output "instance_group_urls" {
  description = "List of GKE generated instance groups"
  value       = module.gke.instance_group_urls[0]
}
output "ca_certificate" {
  sensitive   = true
  description = "Cluster ca certificate (base64 encoded)"
  value       = module.gke.ca_certificate
}
output "endpoint" {
  value     = module.gke.endpoint
  sensitive = true
}
output "cluster_name" {
  value = module.gke.name
}
output "cluster_id" {
  description = "Cluster ID"
  value       = module.gke.cluster_id
}

output "service_account" {
  description = "The service account to default running nodes as if not overridden in `node_pools`."
  value       = module.gke.service_account
}


# output "instance_group_named_port_name" {
#   value = module.gke.instance_group_named_port_name
# }