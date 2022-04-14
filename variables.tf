# variables declaraion
variable "project" {
  description = "GCP Project name"
}

variable "credentials_file" {
  description = "Path to GCP credentials file"
}

variable "project_user_privkey_file" {
  description = "Path to private key file for project user"
}

variable "project_username" {
  description = "Name of the GCP cloud project user"
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
