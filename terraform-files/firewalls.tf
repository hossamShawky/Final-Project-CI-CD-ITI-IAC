# Firewalls
resource "google_compute_firewall" "ssh-rule" {
  name    = "ssh-rule"
  network = google_compute_network.iti-vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"] 
}

resource "google_compute_firewall" "http-rule" {
  name    = "http-rule"
  network = google_compute_network.iti-vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"] 
}