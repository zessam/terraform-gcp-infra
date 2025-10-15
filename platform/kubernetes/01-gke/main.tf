terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.6.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "main" {
  name     = "main-01"
  location = var.region

  # Network configuration
  network    = data.terraform_remote_state.vpc.outputs.network_name
  subnetwork = data.terraform_remote_state.vpc.outputs.private_subnets_names[0]

  # IP ranges for pods and services
  ip_allocation_policy {
    cluster_secondary_range_name  = data.terraform_remote_state.vpc.outputs.first_private_range_name
    services_secondary_range_name = data.terraform_remote_state.vpc.outputs.second_private_range_name
  }

  # Enable GKE features
  enable_autopilot           = false
  enable_shielded_nodes      = true
  enable_intranode_visibility = true
  release_channel {
    channel = "REGULAR"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = true
    }
  }

  # Basic settings
  deletion_protection = false

  # Cluster autoscaling
  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      maximum       = 16
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 1
      maximum       = 24
    }
    auto_repair  = true
    auto_upgrade = true
  }

  # Default node pool disabled — managed separately
  remove_default_node_pool = true
  initial_node_count       = 1
}

# =======================
# Node Pool Configuration
# =======================
resource "google_container_node_pool" "default" {
  name       = "default-node-pool"
  cluster    = google_container_cluster.main.name
  location   = var.region
  node_count = 1

  autoscaling {
    min_node_count = 4
    max_node_count = 10
  }

  node_config {
    machine_type   = "e2-medium"
    disk_type      = "pd-standard"
    disk_size_gb   = 100
    image_type     = "COS_CONTAINERD"
    local_ssd_count = 0
    preemptible     = false
    spot            = false

    labels = {
      default-node-pool = "false"
    }

    tags = [
      "default-node-pool",
      "tf-lb-https-gke"
    ]

    metadata = {
      node-pool-metadata-custom-value = "my-node-pool"
    }

    taint {
      key    = "default-node-pool"
      value  = "true"
      effect = "PREFER_NO_SCHEDULE"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

# =======================
# Firewall Rules (optional)
# =======================
resource "google_compute_firewall" "gke_inbound" {
  count   = var.add_cluster_firewall_rules ? 1 : 0
  name    = "${var.namespace}-gke-inbound"
  network = data.terraform_remote_state.vpc.outputs.network_name

  allow {
    protocol = "tcp"
    ports    = local.firewall_inbound_ports
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["default-node-pool"]
}
