resource "google_compute_subnetwork" "gke-subnet" {
  name                     = "gke-subnet"
  ip_cidr_range            = "10.0.0.0/18"
  region                   = var.region
  network                  = google_compute_network.iti-vpc.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.48.0.0/14"
  }
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.52.0.0/20"
  }
  depends_on = [
    google_compute_network.iti-vpc
  ]

}

resource "google_compute_subnetwork" "iti-subnet" {
  name                     = "iti-subnet"
  ip_cidr_range            = "10.1.0.0/24"
  network                  = google_compute_network.iti-vpc.id
  region                   = var.region
  private_ip_google_access = true

  depends_on = [
    google_compute_network.iti-vpc
  ]

}