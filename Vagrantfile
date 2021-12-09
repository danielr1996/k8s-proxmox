# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "danielr1996/ansible-terraform"
  config.vm.synced_folder "./", "/home/vagrant/cwd", :mount_options => ["fmode=700"]
  config.vm.synced_folder "C:/Users/danie/.kube", "/home/vagrant/.kube", :mount_options => ["fmode=700"]
  config.ssh.extra_args = ["-t", "cd /home/vagrant/cwd; bash --login"]
  config.vm.provision "shell", run: "always", inline: <<SHELL
  echo "export ANSIBLE_TF_DIR=/home/vagrant/cwd/terraform" > /etc/profile.d/env.sh
SHELL
end