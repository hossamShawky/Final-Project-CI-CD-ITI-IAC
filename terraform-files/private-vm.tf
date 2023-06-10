data "google_compute_image" "ubuntu1804" {
  family  = "ubuntu-1804-lts"
  project = "ubuntu-os-cloud"
}


resource "google_compute_instance" "private-vm" {
  name         = "private-vm"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu1804.self_link
      labels = {
        name = "private-vm"
      }
    }
  }

  network_interface {
    network    = google_compute_network.iti-vpc.name
    subnetwork = google_compute_subnetwork.iti-subnet.name
  }

metadata = {
  "startup-script" = file("./startup.sh")
}
}