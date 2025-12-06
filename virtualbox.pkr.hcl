variable "iso_url" {
  type        = string
  description = "URL of Base ISO image"
  default     = "https://download.fedoraproject.org/pub/fedora/linux/releases/43/Server/x86_64/iso/Fedora-Server-dvd-x86_64-43-1.6.iso"
}

variable "iso_checksum" {
  type        = string
  description = "Checksum to verify integrity of ISO file"
  default     = "sha256:aca06983bef83da9b43144c1a2ff4c8483e4745167c17f53725c16a16742e643"
}


source "virtualbox-iso" "fedora" {
  vm_name = "packer-fedora-vm"

  iso_url      = var.iso_url
  iso_checksum = var.iso_checksum

  ssh_username = "packer"
  ssh_password = "packer"

  disk_size = 512
  memory    = 512
  cpus      = 1
}

build {
  sources = ["source.virtualbox-iso.fedora"]

  provisioner "shell" {
    inline = [
      "sudo echo 'hello world' > /usr/hello.txt"
    ]
  }
}
