source "docker" "ubuntu" {
  image  = "ubuntu:jammy"
  commit = true
}

build {
  name = "learn-packer"
  sources = [
    "source.docker.ubuntu"
  ]


  post-processors {
    post-processor "docker-tag" {
      repository = "hello-world/image"
      tags       = ["pepik"]
    }
  }

}

