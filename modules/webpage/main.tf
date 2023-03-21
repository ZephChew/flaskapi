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
  host = "tcp://localhost:2375" #for WSL version 1
  #host = "npipe:////.//pipe//docker_engine"
}

#webpage flask
resource "docker_image" "flask" {
  name = "flask-${var.environment}:latest"
  build {
    path       = "./modules/webpage/flask"
    dockerfile = "Dockerfile"
  }
  keep_locally = false

}

resource "docker_container" "flask" {
  image = docker_image.flask.name
  name  = "flask_container"
  ports {
    internal = 80
    external = 81
  }
  #mount volumne for downloaded packages
  volumes {
    #host_path changed due to using window's docker desktop 
    #/mnt/c is for linux WSL2 or linux docker
    container_path = "/downloads"
    host_path      = "/c/Users/Chew Shi Tian/Downloads/00. Work/gcc/localnexus/modules/webpage/packages/"
    read_only      = false
  }
  #mount gunicorn and python file to load webpage
  volumes {
    container_path = "/opt/app"
    host_path      = "/c/Users/Chew Shi Tian/Downloads/00. Work/gcc/localnexus/modules/webpage/flask/"
    read_only      = true
  }
  #start gunicorn
  command = ["gunicorn", "--bind", "0.0.0:80", "wsgi:app"]
}

#postgres 
resource "docker_image" "postgres" {
  name = "postgres-${var.environment}:latest"
  build {
    path       = "./modules/webpage/postgres"
    dockerfile = "Dockerfile"
  }
  keep_locally = false
}

resource "docker_container" "postgres" {
  image      = docker_image.postgres.name
  name       = "postgres_flask"
  depends_on = [docker_container.flask]
  #environment variable
  #env = ["POSTGRES_PASSWORD = postgres"]
  #command = ["postgres"]
  #command = ["/bin/bash", "-c", "tail -f /dev/null"]

  volumes {
    #host_path changed due to using window's docker desktop 
    #/mnt/c is for linux WSL2 or linux docker
    host_path      = "/c/Users/Chew Shi Tian/Downloads/00. Work/gcc/localnexus/modules/webpage/postgres/data"
    container_path = "/var/lib/postgresql/data"
    read_only      = false
  }

  ports {
    internal = 5432
    external = 5432
  }
}

# resource "docker_volume" "flask_python" {
#   name = "flask_python"
# }

# resource "docker_volume" "flask_downloads" {
#   name = "flask_downloads"
# }