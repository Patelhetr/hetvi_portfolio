
provider "google" {
  credentials = file("hetviwebsite.json")
  project     = var.project_id
  region      = var.region
}

resource "google_storage_bucket" "website_bucket" {
  name          = "${var.project_id}-portfolio"
  location      = var.region
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.website_bucket.name
  role   = "roles/storage.objectViewer"
  members = ["allUsers"]
}

resource "google_storage_bucket_object" "files" {
  for_each = fileset("website-files", "**")

  name   = each.value
  source = "website-files/${each.value}"
  bucket = google_storage_bucket.website_bucket.name
}
