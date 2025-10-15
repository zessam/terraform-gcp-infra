provider   "google"  {
    credentials = file("C:/Users/zeyad/Downloads/terraform-gcp-infra/pseudo-credential.txt")
      project     = var.project_id
      region      = var.region
    }

  




variable "gcp_credentials_file" {
  description = "Path to the JSON key file for GCP authentication."
}

locals {
  environment = format("%s-%s-%s", var.namespace, var.stage, var.region)
}




variable "project_id" {
  description = "This is the GCP project ID as set in the shared credentials file"
  type        = string
}


variable "bucket_name" {
  description = "The name of the GCP bucket"
  default     = "terraform-state"
  type        = string
}



variable "namespace" {
  description = "The namespace (e.g. `finx`)"
  type        = string
}

variable "stage" {
  description = "The stage (e.g. `dev`, `stage`, `prod`, `test`)"
  type        = string
}

variable "region" {
  description = "The GCP region (e.g. `us-central1`)"
  type        = string
}

variable "public_sub" {
  description = "The subnet range"
  type        = string
}
variable "private_sub" {
  description = "The subnet range"
  type        = string
}
variable "private_secondary_01" {
  description = "The subnet range"
  type        = string
}

variable "private_secondary_02" {
  description = "The subnet range"
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Resource tags (e.g. `map('BusinessUnit','XYZ')`"
}


