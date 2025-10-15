resource "google_storage_bucket" "terraform_state" {
  name     = var.bucket_name
  location = "ME-CENTRAL2"
  uniform_bucket_level_access = true
  #force_destroy = true
  
}