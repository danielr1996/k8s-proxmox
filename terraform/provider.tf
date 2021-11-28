terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.3"
    }
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
  }
}

provider "proxmox" {
    pm_api_url = var.pm_api_url
    pm_user = var.pm_user
    pm_password = var.pm_password
    pm_tls_insecure = var.pm_tls_insecure
}

provider "ansible" {}