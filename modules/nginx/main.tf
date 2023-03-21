terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.22.0"
    }
  }
}

# Specifying the Docker provider configuration
provider "docker" {
  #host = "unix:///var/run/docker.sock"
  host = "tcp://localhost:2375"
}


resource "docker_image" "nginx" {
  name = "nginx-${var.environment}:latest"
  build {
    path       = "./modules/nginx"
    dockerfile = "Dockerfile"
  }
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx_webpage"
  ports {
    internal = 80
    external = 8080
  }
}

