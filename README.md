# kubernetes-proxmox
Combination of terraform and ansible scripts to automatically provision a highly available kubernetes cluster on Proxmox VE

> Audience: This is not a turnkey solution to setup a kubernetes cluster nor should it be used as production deployment. While most aspects are automated and most decisions are already made for you it might still me necessary to adjust the settings depending on your specific environment. Therefore knowledge on how to use `terraform`, `ansible` and `kubeadm` is not strictly required but highly recommended. Refers to the links at the bottom for additional resources.

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

## Next steps
Now you have a running kubernetes cluster ready to receive workloads, however you might want to install additional software for a bare metal setup:

* metallb: depending on your infrastructure you might want to run metallb to assign a local ip to Services of type LoadBalancer
* traefik: to easily expose Services under a DNS name
* storage: install a supported storage driver to enable persistent volumes
* argocd: install apps with a gitops workflow

To do so run `ansible-playbook playbook.yaml --tags=bootstrap`

### traefik
> Currently traefik is configured to use Hetzner, specify your token with the following command:
```
kubectl create secret generic hetzner-api-token -ninfra --from-literal=token=<token> 
```

### argocd
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
```

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

To join worker and controlplane nodes afterward see [https://stackoverflow.com/questions/51126164/how-do-i-find-the-join-command-for-kubeadm-on-the-master](https://stackoverflow.com/questions/51126164/how-do-i-find-the-join-command-for-kubeadm-on-the-master)

Remember to also pass `--apiserver-bind-port=8443`