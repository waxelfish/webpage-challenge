output "Private_IP" {
  value = google_compute_instance.vm_instance.network_interface.0.network_ip
}

output "Ephemeral_External_IP" {
  value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}

output "Server_ID" {
  value = google_compute_instance.vm_instance.id
}
