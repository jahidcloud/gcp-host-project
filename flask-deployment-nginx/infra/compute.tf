
resource "google_compute_instance" "app" {
  name         = "app-server"
  machine_type = "f1-micro"
  zone         = "us-central1-a"


  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  tags = ["ssh-access", "flask-instance"]

  metadata_startup_script = <<EOF
    # Install Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    apt-get install -y docker-compose

    # Install Git
    apt-get update
    apt-get install -y git
    git clone https://github.com/jahidcloud/gcp-host-project.git
  EOF

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name

    access_config {
      // Assign the custom public IP address to the instance
      nat_ip = google_compute_address.flaskapp.address
    }
  }
}
