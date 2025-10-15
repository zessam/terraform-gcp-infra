terraform {
  required_providers {
    google = {
      credentials = file(var.gcp_credentials_file)
      project     = var.project_id
      region      = var.region
    }

  }
}


variable "gcp_credentials_file" {
  description = "Path to the JSON key file for GCP authentication."
}

locals {
  environment = format("%s-%s-%s", var.namespace, var.stage, var.region)
}


variable "profile" {
  description = "This is the AWS profile name as set in the shared credentials file"
  type        = string
}

variable "project_id" {
  description = "This is the GCP project ID as set in the shared credentials file"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "bucket" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "domain" {
  description = "The DNS domain name"
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

variable "vault_addr" {
  description = "Address of the Vault server expressed as a URL"
  type        = string
}