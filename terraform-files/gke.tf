resource "google_container_cluster" "iti-cluster" {
  name                     = "iti-cluster"
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.iti-vpc.self_link
  subnetwork               = google_compute_subnetwork.gke-subnet.self_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"
  ip_allocation_policy {
  }
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.1.0.0/24"
      display_name = "iti-subnet_Managment"
    }

  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

}

# creare ServiceAccount&IAM roles => control cluster with specific permissions
resource "google_service_account" "k8s-sa" {
  account_id = "k8s-sa"
}
resource "google_project_iam_member" "k8s-roles" {
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.k8s-sa.email}"
  project = var.project
}
# 
resource "google_container_node_pool" "general-pool" {
  name       = "general"
  cluster    = google_container_cluster.iti-cluster.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    labels = {
      role = "general"
    }

    service_account = google_service_account.k8s-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}