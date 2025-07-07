terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "appnet" {
  name = "appnet"
}

resource "docker_image" "flask" {
  name         = "flask-vue-crud-server:latest"
  build {
    context    = "../flask-vue-crud/server"
  }
}

resource "docker_container" "flask" {
  name  = "flask"
  image = docker_image.flask.latest
  networks_advanced {
    name = docker_network.appnet.name
  }
  env = ["FLASK_ENV=production"]
  ports {
    internal = 5000
    external = 5000
  }
}

resource "docker_image" "vue" {
  name         = "flask-vue-crud-client:latest"
  build {
    context    = "../flask-vue-crud/client"
  }
}

resource "docker_container" "vue" {
  name  = "vue"
  image = docker_image.vue.latest
  networks_advanced {
    name = docker_network.appnet.name
  }
  ports {
    internal = 80
    external = 80
  }
}

resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.latest
  networks_advanced {
    name = docker_network.appnet.name
  }
  ports {
    internal = 443
    external = 443
  }
  volumes {
    host_path      = "../docker/nginx/default.conf"
    container_path = "/etc/nginx/conf.d/default.conf"
    read_only      = true
  }
  volumes {
    host_path      = "../docker/nginx/certs"
    container_path = "/etc/nginx/certs"
    read_only      = true
  }
  depends_on = [docker_container.flask, docker_container.vue]
}

resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.prometheus.latest
  networks_advanced {
    name = docker_network.appnet.name
  }
  ports {
    internal = 9090
    external = 9090
  }
  volumes {
    host_path      = "../docker/prometheus/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
    read_only      = true
  }
}

resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.grafana.latest
  networks_advanced {
    name = docker_network.appnet.name
  }
  ports {
    internal = 3000
    external = 3000
  }
}