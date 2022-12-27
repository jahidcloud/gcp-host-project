

#### Configuring GCE #####
resource "google_compute_instance" "app" {
  name         = "app-server"
  machine_type = "f1-micro"
  zone         = "us-central1-a"


  #### OS IMAGE Configuration ####
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  tags = ["ssh-access", "flask-instance"]

  ### Points to a seperate bash script using tf data resource to render upon install###
  metadata_startup_script = data.template_file.install_userdata.rendered

  ###Specifiying which vpc and subnet to deploy the GCE to #### 
  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name

    ### Assigning GCE instance Emphermeral IP Addresses ###
    access_config {
      // Assign the custom public IP address to the instance
      nat_ip = google_compute_address.flaskapp.address
    }
  }
}

### Configuring tf data resource to point to render bash script ###
data "template_file" "install_userdata" {
  template = file("./templates/userdata.sh")
}
