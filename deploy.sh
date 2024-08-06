#!/bin/bash

# Variables
PROJECT_ID="shining-energy-431601-h5"
REGION="us-central1"
ZONE="us-central1-a"
MACHINE_TYPE="e2-medium"
IMAGE="debian-cloud/debian-11"
DISK_SIZE="10"
INSTANCE_NAME="terraform-vm-instance-1"
SERVICE_ACCOUNT_KEY="/home/rakshitha/Downloads/shining-energy-431601-h5-b70c520ac73a.json"
TF_DIRECTORY="gcp-vm-deployment"

# Export Google Application Credentials
export GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_KEY"

# Create Terraform configuration directory
mkdir -p $TF_DIRECTORY
cd $TF_DIRECTORY

# Create main.tf
cat <<EOF > main.tf
provider "google" {
  credentials = file("$SERVICE_ACCOUNT_KEY")
  project     = "$PROJECT_ID"
  region      = "$REGION"
}

resource "google_compute_instance" "vm_instance" {
  name         = "$INSTANCE_NAME"
  machine_type = "$MACHINE_TYPE"
  zone         = "$ZONE"

  boot_disk {
    initialize_params {
      image = "$IMAGE"
      size  = $DISK_SIZE
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral external IP
    }
  }
}
EOF

# Initialize Terraform
terraform init

# Plan Terraform deployment
terraform plan

# Apply Terraform configuration
terraform apply -auto-approve

echo "Terraform VM deployment completed."
