# terraform

> This document describes the terraform aspects in more detail, for a general overview see ../README.md

terraform is used to create your vms in proxmox, additionaly it creates resources for ansible to hook into later.

## Configuration
The terraform resources use two different types of types of configuration, user configuration and cluster configuration.
* user configuration contains variables specific to your environment, like credentials for proxmox or which vm template to use
* cluster configuration contains the values used to configure your cluster like how many cpu cores to use for your node or how many nodes you want

### user configuration
user configuration is specified through `user.auto.tfvars`, `user.auto.tfvars.example` is included as a reference with all configurable variables.
To supply your configuration copy `user.auto.tfvars.example` to `user.auto.tfvars` and supply the values appropriate for your environment.

### cluster configuration
cluster configuration can be specified through `cluster.auto.tfvars`. You do not need to change anything as defaults are included. 
However if you want to change something copy `cluster.auto.tfvars.example` to `cluster.auto.tfvars` and adjust to your liking