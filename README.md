# webpage-challenge Project

**Objective**: Deploy VM instance in GCP cloud using Terraform, configure Nginx websever serving a static page via HTTPS with Ansible.


## Prerequisites

This challenge requires an existing GCP project with a default user and automatic ssh key deployment onto VM instances for said user.

Deployment and configuration of the GCP cloud resources requires a local installation of the following tools:

- Terraform (>= v1.1.x)
- Ansible (>= v2.10.x)


## Configuration

The following two Terraform variables need to be specified in order for the deployment to succeed:

- ***project***: Name of the GCP project to deploy into 
- ***credential_file***: path to a valid GCP credential file for the above project in JSON format

This can be done by either directly editing **terraform.tfvars** or by providing the following **TF_VAR_** environment variables, exported in BASH prior to Terraform deployment via

> $ export TF_VAR_project=name of GCP project

> $ export TF_VAR_credentials_file=path to file


Alternatively, if not previously defined, `terraform plan|apply` will prompt for both before running.

Note: The GCP credentials file must be in valid JSON format, generated in the GCP console and downloaded to the local system.

## Initialization

To initialize the Terraform deployment, run the following command in the project's main directory 

> $ terraform init

This will download the required providers and provisioners into the `.terraform` directory.

## Deployment

> $ terraform apply

The deployment will create the following GCP cloud resources in the `us-central1` region (defaults defined in `variables.tf`):

- **e2-micro** VM instance (most recent Ubuntu 20.04 LTS AMI image)
- custom network
- firewall rules, allowing access via ICMP, SSH, HTTP, and HTTPS

Utilizing a local provisioner, the deployment will then create SSL keys and x509 certificates in the main project directory in the `./pki` folder via 
a local Ansible playbook.

Installation and configuration of the Nginx webserver on the VM instance is then executed via a second Ansible playbook.


The Terraform output module will list the `Ephemeral_External_IP` of the VM instance created after successful deployment. 

The deployed website can be viewed in a the webbrower via:


`https://Ephemeral_External_IP`


## Cleanup

> $ terraform apply -destroy

The above command will tear down the GCP deployment.




