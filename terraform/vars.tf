# user configuration

variable "pm_api_url" {
    description = "Proxmox API endpoint, e.g. https://<ip>:8006/api2/json"
    type = string
}

variable "pm_user" {
    description = "Proxmox user, e.g. root@pam"
    type = string
}

variable "pm_password" {
    description = "Proxmox password"
    type = string
    sensitive = true
}

variable "pm_target_node" {
    description = "Proxmox node to start the vm on"
    type = string
    default ="pve"
    
}

variable "pm_tls_insecure" {
    description = "wether your proxmox instance uses a self signed certificate"
    default = false
    type = bool
}

variable "vm_template" {
    description = "Name of the proxmox template or vm to clone from (Note: this is the displayed name, not the id)"
    type = string
}
variable "vm_user" {
    description = "username of the the vm, e.g. for the ubuntu cloud image this is 'ubuntu'"
}

variable "ssh_key" {
    description = "private and public key uploaded to your nodes and used for ansible to connect"
    type=object({
        private = string
        public = string
    })
    sensitive = true
}


# cluster configuration

variable "controlplane_count" {
    description = "Number of controlplane nodes"
    default = 2
    type = number
}
variable "controlplane_cores" {
    description = "Number of cpu core for controlplane node"
    default = 2
    type = number
}
variable "controlplane_memory" {
    description = "Amount of memory for controlplane node"
    default=2048
    type = number
}
variable "worker_count" {
    description = "Number of worker nodes"
    default = 2
    type = number
}
variable "worker_cores" {
    description = "Number of cpu core for worker node"
    default = 2
    type = number
}
variable "worker_memory" {
    description = "Amount of memory for worker node"
    default=3072
    type = number
}
