variable "region" {
  type    = string
  default = "us-east1"
}

variable "zone" {
  type    = string
  default = "us-east1-b"
}
variable "machine_type" {
  type    = string
  default = "e2-small"
}
variable "project" {
  type = string
}

variable "service_account" {
  type = string
}