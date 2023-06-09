# Enable Compute&Container APIs

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

resource "google_compute_network" "iti-vpc" {
  name                            = "iti-vpc"
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}

resource "google_compute_router" "iti-router" {
  name    = "iti-router"
  region  = var.region
  network = google_compute_network.iti-vpc.id
}



resource "google_compute_router_nat" "iti-nat" {
  name   = "iti-nat"
  router = google_compute_router.iti-router.name
  region = "us-central1"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"
}

resource "google_compute_address" "nat" {
  name         = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM" # higher availability and lower latency
  depends_on   = [google_project_service.compute]
}


# Firewalls
resource "google_compute_firewall" "ssh-rule" {
  name    = "ssh-rule"
  network = google_compute_network.iti-vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  direction     = "INGRESS"
  source_ranges = ["41.65.244.66/20"] #MyIP
}

resource "google_compute_firewall" "http-rule" {
  name    = "http-rule"
  network = google_compute_network.iti-vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  direction     = "INGRESS"
  source_ranges = ["41.65.244.66/20"] #MyIP
}