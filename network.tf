# firewall rules

# Allow ingress ssh
resource "google_compute_firewall" "filewall-ssh-rule" {
  name    = "terraform-network-firewall-allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  source_tags = ["ssh"]
}

# Allow ingress http/https
resource "google_compute_firewall" "filewall-web-rule" {
  name    = "terraform-network-firewall-allow-web"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]

  source_tags = ["http", "https"]
}


# Allow ingress ping
resource "google_compute_firewall" "firewall-icmp-rule" {
  name    = "terraform-network-firewall-allow-icmp"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]

  source_tags = ["icmp"]
}

# Allow ingress from GCP internal services
resource "google_compute_firewall" "firewall-internal-rule" {
  name    = "terraform-network-firewall-allow-internal"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.128.0.0/9"]

  source_tags = ["internal"]

  priority = 65534
}

# custom network for terraform deployments
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
