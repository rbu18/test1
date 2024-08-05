provider "google" {
  credentials = file("/home/rakshitha/Downloads/shining-energy-431601-h5-b70c520ac73a.json")
  project     = "shining-energy-431601-h5"
  region      = "us-central1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-vm-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral external IP
    }
  }
}

