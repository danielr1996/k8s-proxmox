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