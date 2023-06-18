# Create Bucket To Upload deployment files
resource "google_storage_bucket" "cicd-bucket-hossam" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true

}
resource "google_storage_bucket_object" "upload-files" {
  for_each     = fileset("../deployments", "*.yml")
  name         = each.value
  bucket       = google_storage_bucket.cicd-bucket-hossam.name
  source       = "../deployments/${each.value}"
  content_type = "text/plain"
}

resource "google_storage_bucket_iam_binding" "bucket_viewer" {
  bucket = google_storage_bucket.cicd-bucket-hossam.name
  role   = "roles/storage.objectViewer"

  members = [
    # "serviceAccount:${var.service_account}",
    "serviceAccount:${google_service_account.k8s-sa.email}",
    "allUsers"
  ]
}