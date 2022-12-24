resource "google_compute_network" "vpc" {
  name                    = "custom-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "custom-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc.self_link
  region        = "us-central1"
}

resource "google_compute_address" "flaskapp" {
  name = "app-ip"
}
