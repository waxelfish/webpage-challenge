# grab most recent image name from cloud instead of hardcoding it
data "google_compute_image" "linux_image" {
  family  = var.image_family
  project = var.image_project
}

# data source for cloud init script
data "cloudinit_config" "conf" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = file("./cloud-init.yaml")
    filename     = "./cloud-init.yaml"
  }
}
