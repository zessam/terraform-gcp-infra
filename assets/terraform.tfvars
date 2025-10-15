# provider
project_id           = "bbc-goatheeb"
profile              = "goatheeb-prod"
region               = "me-central2"
domain               = "bevatel.com"
gcp_credentials_file = "/Users/hakim/Bevatel/IAM/bbc-goatheeb-037ab3213bb7.json"

# environment
namespace  = "goatheeb"
stage      = "prod"
bucket     = "goatheeb-prod-ksa-state"
vault_addr = "https://vault-go.bevatel.com"
# network
public_sub           = "10.9.0.0/16"
private_sub          = "10.10.0.0/16"
private_secondary_01 = "10.20.0.0/16"
private_secondary_02 = "10.30.0.0/16"

# tagging
tags = {
  platform = "goatheeb"
  env      = "prod"
  app      = "infra"
}
