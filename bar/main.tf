terraform {
  backend "etcdv3" {
    endpoints = ["localhost:2379"]
    lock      = true
    prefix    = "terraform-state/bar"
  }
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
}

provider "docker" {}

resource "docker_container" "bar" {
  image = docker_image.ubuntu.latest
  command = ["sleep", "1d"]
  name  = "bar"
}

resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
  keep_locally = true
}
