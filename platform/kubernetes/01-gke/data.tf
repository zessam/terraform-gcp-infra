data "google_compute_zones" "available_zones" {}
data "google_client_config" "default" {}

data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    bucket = "terraform-state"
    prefix = "platform/network/vpc.state"
  }
}

locals {
  zones                  = data.google_compute_zones.available_zones.names
  firewall_inbound_ports = ["80", "443", "32065", "32080"]
  #  zones                      = ["us-west1-a", "us-west1-b", "us-west1-c"]
}
provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}