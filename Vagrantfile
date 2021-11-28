# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "danielr1996/ansible-terraform"
  config.vm.synced_folder "./", "/home/vagrant/proxmox-kubernetes", :mount_options => ["fmode=700"]
  config.ssh.extra_args = ["-t", "cd /home/vagrant/proxmox-kubernetes; bash --login"]
  config.vm.provision "shell", run: "always", inline: <<SHELL
  echo "export ANSIBLE_TF_DIR=/home/vagrant/proxmox-kubernetes/terraform" > /etc/profile.d/env.sh
SHELL
end