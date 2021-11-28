# kubernetes-proxmox
Combination of terraform and ansible scripts to automatically provision a highly available kubernetes cluster on Proxmox VE

> This is still a work a progress, currently vms can be automatically created and provisioned through terraform, however the `kubeadm init` and `kubeadm join` commands need to be executed manually

> Audience:

## Usage
For a batteries included solution a `Vagrantfile` is included which has terraform and ansible installed and configured. 
If you do not want to use vagrant see the "Without vagrant" section.

### With vagrant
[Download and install vagrant according to their documentation](https://www.vagrantup.com/docs/installation). You must use virtualbox because the box does not support other providers. For more information on the vagrant box see [danielr1996/vagrant-ansible-terraform](https://github.com/danielr1996/vagrant-ansible-terraform).

Initialize the vagrant box, start it and login
```
vagrant init
vagrant up
vagrant ssh
```

To create resources run
```
cd terraform && terraform apply
```

To provision resources run
```
cd ansible && ansible-playbook playbook.yaml
```

### Without vagrant
The vagrant box comes with the [terraform-inventory](https://github.com/nbering/terraform-inventory) inventory plugin preconfigured, therefore you need to configure ansible manually to use the plugin. For terraform it doesn't matter where you run it. 

For ansible make sure to include the terraform inventory script and specify your terraform directory as an environment variable
```
ANSIBLE_TF_DIR=../terraform ansible-playbook -i terraform.py playbook.yaml 
```

## Installing kubernetes with kubeadm
> This should be moved to ansible, but for now you need to execute these steps manually. 

Login to your first controlplane node and run kubeadm. Depending on your situation you might supply additional arguments to kubeadm, the option your are most likely to need is `--pod-network-cidr`, depending on your CNI. This guide uses [weave](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/) which works with the default. For a comprehensive list of arguments refer to the [kubadm documentation](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/).

```
sudo kubeadm init \
    --control-plane-endpoint=10.0.100.1:6443 \ 
    --upload-certs \
    --apiserver-bind-port=8443
```

To join your remaining controlplane and worker nodes follow the steps printed by `kubeadm init`.

## Useful resources
This a list of additional documentation I used and useful commands for debugging

* [https://kubernetes.io/docs/reference/setup-tools/kubeadm/](https://kubernetes.io/docs/reference/setup-tools/kubeadm/)

* [https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/)

* [https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md#options-for-software-load-balancing](https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md#options-for-software-load-balancing)

Reset a node after `kubeadm init`
```
kubeadm reset
```

Check if your node meets the requirements
```
kubeadm init phase preflight
```