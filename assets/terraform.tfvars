# provider
project_id           = ""
region               = "me-central2"
gcp_credentials_file = ""

# environment
namespace  = ""
stage      = "prod"
#bucket_name     = "terraform-state"

# network
public_sub           = "10.9.0.0/16"
private_sub          = "10.10.0.0/16"
private_secondary_01 = "10.20.0.0/16"
private_secondary_02 = "10.30.0.0/16"

# tagging
tags = {
  platform = ""
  env      = "prod"
  app      = "infra"
}
