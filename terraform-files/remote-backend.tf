# terraform {
#   backend "gcs" {
#     bucket = "iti-tf-state-finaltask"
#     prefix = "terraform/state"
#   }
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "~> 4.0"
#     }
#   }
# }