# Write ssh key to ansible folder, used for ansible to connect to host

resource "local_file" "ansible_ssh_key" {
  content = var.ssh_key.private
  filename = "../ansible/ssh_key_terraform"
}