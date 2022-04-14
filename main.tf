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

  # GCP specific SSH key on VM is stored in console and will be added to VM automatically

  # diabled in favor of ansible playbook. Cloud-init runs in the background after VM initialization
  # often interferring with package configuration if done via cloud-init rather than ansible!
  #metadata = {
  #  user-data = "${data.cloudinit_config.conf.rendered}"
  #}

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      // Ephemeral public IP
    }
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
    echo "webserver ansible_host=${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}" > inv
    echo -e "\n[all:vars]\nPKI_DIR=\"./pki\"\n" >> inv
    ansible-playbook -i inv local_playbook.yml --tags pki -e "gcp_ip_address=${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inv playbook.yml
    EOT
  }
}
