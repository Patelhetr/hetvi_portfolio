
output "website_url" {
  value = "http://${google_storage_bucket.website_bucket.name}.storage.googleapis.com/index.html"
}
