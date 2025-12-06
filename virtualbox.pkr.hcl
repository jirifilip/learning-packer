variable "iso_url" {
  type        = string
  description = "URL of Base ISO image"
  default     = "https://download.fedoraproject.org/pub/fedora/linux/releases/43/Cloud/x86_64/images/Fedora-Cloud-Base-AmazonEC2-43-1.6.x86_64.raw.xz"
}

variable "iso_checksum" {
  type        = string
  description = "Checksum to verify integrity of ISO file"
  default     = "sha256:91a3fa8f5fd870ca4de56c24df97ceb4f8bd806c2e01a1a8a4fa780395a84bfc"
}

source "virtualbox-iso" "fedora" {
  vm_name       = "packer-fedora-vm"
  guest_os_type = "Fedora_64"

  iso_url      = var.iso_url
  iso_checksum = var.iso_checksum

  ssh_username = "packer"
  ssh_password = "packer"

  disk_size = 512
  memory    = 512
  cpus      = 1

  shutdown_command = "sudo /sbin/shutdown -h now"
}

build {
  sources = ["source.virtualbox-iso.fedora"]

  provisioner "shell" {
    inline = [
      "sudo echo 'hello world' > /usr/hello.txt"
    ]
  }
}
