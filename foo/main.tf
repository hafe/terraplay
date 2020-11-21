terraform {
  backend "etcdv3" {
    endpoints = ["localhost:2379"]
    lock      = true
    prefix    = "terraform-state/foo"
  }
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
}

provider "docker" {}

resource "docker_container" "foo" {
  image = docker_image.ubuntu.latest
  command = ["sleep", "1d"]
  name  = "foo"
}

resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
  keep_locally = true
}
