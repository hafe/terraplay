terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
}

provider "docker" {}

resource "docker_image" "etcd" {
  name         = "quay.io/coreos/etcd:v3.4.13"
  keep_locally = true
}

resource "docker_volume" "etcd" {
  name = "etcd"
}

resource "docker_container" "etcd" {
  image = docker_image.etcd.latest
  name  = "etcd"
  command = ["etcd", "--advertise-client-urls", "http://0.0.0.0:2379", "--listen-client-urls", "http://0.0.0.0:2379"]
  capabilities {
    drop = ["ALL"]
  }
  ports {
    internal = 2379 
    external = 2379
  }
  restart = "always"
  volumes {
    volume_name = "etcd"
    container_path = "/var/lib/etcd"
  }
}
