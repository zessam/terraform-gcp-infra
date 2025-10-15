terraform {
  backend "gcp" {
    bucket_name = "terraform-state"
    prefix      = "platform/network/vpc.state"
  }
}


# ========================================
# VPC NETWORK
# ========================================
resource "google_compute_network" "vpc" {
  name                    = "${var.namespace}-${var.stage}-vpc"
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

# ========================================
# SUBNETS
# ========================================
resource "google_compute_subnetwork" "public" {
  name          = "public"
  ip_cidr_range = var.public_sub
  region        = var.region
  network       = google_compute_network.vpc.id
  project       = var.project_id
  description   = "Public subnet"
}

resource "google_compute_subnetwork" "private" {
  name                     = "private"
  ip_cidr_range            = var.private_sub
  region                   = var.region
  network                  = google_compute_network.vpc.id
  project                  = var.project_id
  private_ip_google_access = true
  description              = "Private subnet for internal workloads"

  # Secondary ranges (used for GKE)
  secondary_ip_range {
    range_name    = "private-secondary-01"
    ip_cidr_range = var.private_secondary_01
  }

  secondary_ip_range {
    range_name    = "private-secondary-02"
    ip_cidr_range = var.private_secondary_02
  }

  # Flow log config
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.7
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

# ========================================
# ROUTES
# ========================================
resource "google_compute_route" "egress_internet" {
  name              = "egress-internet"
  description       = "Route through default internet gateway to access internet"
  network           = google_compute_network.vpc.id
  dest_range        = "0.0.0.0/0"
  next_hop_gateway  = "default-internet-gateway"
  project           = var.project_id
}
