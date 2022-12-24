resource "google_compute_firewall" "public_ssh" {
  name    = "public-ssh"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-access"]
  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}


resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["flask-instance"]
  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

