resource "docker_image" "nginx" {
  name = "custom-nginx:latest"

  build {
    context    = "${path.module}/nginx-custom"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "nginx" {
  name  = "nginx-lab"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8080
  }

  network_mode = docker_network.app_net.name
}





resource "docker_image" "flask_app" {
  name         = "flask_app:latest"
  build {
    context    = "${path.module}/flask-app"
    dockerfile = "Dockerfile"
  }
  keep_locally = false
}

resource "docker_container" "flask_app" {
  name  = "myflaskapp"
  image = docker_image.flask_app.name

  ports {
    internal = 5000
    external = 5001
  }

  network_mode = docker_network.app_net.name

}


resource "docker_network" "app_net" {
  name = "app_net"

}
