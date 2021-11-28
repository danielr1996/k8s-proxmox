module "controlplane" {
    count = var.controlplane_count
    memory = var.controlplane_memory
    cores = var.controlplane_cores
    source = "./node"
    ssh_key = var.ssh_key
    name = "k8s-controlplane${count.index}"
    groups = ["controlplane"]
    ha_priority = count.index
    user = var.vm_user
    template = var.vm_template
    pm_target_node = var.pm_target_node
}

module "worker" {
    count = var.worker_count
    memory = var.worker_memory
    cores = var.worker_cores
    source = "./node"
    ssh_key = var.ssh_key
    name = "k8s-worker${count.index}"
    groups = ["worker"]
    user = var.vm_user
    template = var.vm_template
    pm_target_node = var.pm_target_node
}