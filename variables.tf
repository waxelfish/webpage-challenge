# variables declaraion
variable "project" {
  description = "Project name"
}

variable "credentials_file" {
  description = "Path to GCP credentials file"
}

variable "region" {
  description = "Default Region"
  default     = "us-central1"
}

variable "zone" {
  description = "Default Zone"
  default     = "us-central1-c"
}

#variable "image" {
#  description = "Default Linux AMI Image"
#  default     = "ubuntu-pro-2004-focal-v20220411"
#  #default = "debian-9"
#}

variable "image_family" {
  description = "Default Linux AMI Image Family"
  default     = "ubuntu-pro-2004-lts"
}

variable "image_project" {
  description = "Default Linux AMI Image Project"
  default     = "ubuntu-os-pro-cloud"
}

# https://cloud.google.com/free/
variable "machine_type" {
  default     = "e2-micro"
  description = "Default machine type (free)"
}
