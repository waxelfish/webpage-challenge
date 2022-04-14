# Compute instance
resource "google_compute_instance" "vm_instance" {
  name         = "challenge-webserver"
  machine_type = var.machine_type

  tags = ["terraform", "webserver"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.linux_image.self_link
    }
  }

  # place GCP specific SSH key on VM
  # not necessary as key is stored in console and will be added to VM automatically
  metadata = {
    #  ssh-keys = "axel:${file("./google_compute_engine.pub")}"
    user-data = "${data.cloudinit_config.conf.rendered}"
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    #network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  provisioner "local-exec" {
    command = <<EOT
    ssh-keyscan -t ecdsa -H ${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip} >> ~/.ssh/known_hosts
    echo "webserver PKI_DIR=\"./pki\" ansible_host=${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}" > inv
    EOT
  }
}

#     ansible-playbook -i inv local_playbook.yml --tags pki -e "gcp_ip_address=${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
#    ssh-keyscan -t dsa -H ${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip} >> ~/.ssh/known_hosts
