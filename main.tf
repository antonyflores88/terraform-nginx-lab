resource "docker_image" "nginx" {
  name = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  name  = "mynginx"
  image = docker_image.nginx.name
  ports {
    internal = 80
    external = 8080
  }
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
}