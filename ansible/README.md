# ansible

> This document describes the ansible aspects in more detail, for a general overview see ../README.md

ansible is used to install and configure the software needed for kubernetes, additionaly it uses resources created by terraform to configure which hosts to use.

## Configuration
> currently nothing can be configured on the ansible side, in the future options to configure which cni plugin to use or additional kubeadm args may be configurable