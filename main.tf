resource "docker_image" "nginx" {
  name = "custom-nginx:latest"

  build {
    context    = "${path.module}/nginx-custom"
    dockerfile = "${path.module}/nginx-custom/Dockerfile"
  }
}

resource "docker_container" "nginx" {
  name  = "nginx-lab"
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = 8080
  }
  
  #adding all three networks to nginx container
  networks_advanced {
    name = docker_network.vnet_prod.name
  }
  networks_advanced {
    name = docker_network.vnet_staging.name
  }
  networks_advanced {
    name = docker_network.vnet_dev.name
  }

  #Ensuring that nginx starts after all app containers are running
  depends_on = [ 
    docker_container.app_prod,
    docker_container.app_staging,
    docker_container.app_dev 
    ]
}





resource "docker_image" "flask_app" {
  name         = "flask_app:latest"
  build {
    context    = "${path.module}/flask-app"
    dockerfile = "Dockerfile"
  }
  keep_locally = false
}

#Production Environment
resource "docker_container" "app_prod" {
  name  = "app-prod"
  image = docker_image.flask_app.name

  ports {
    internal = 5000
    external = 5001
  }

  networks_advanced {
    name = docker_network.vnet_prod.name
  }

    env = ["ENVIRONMENT=prod"]

}

#staging Environment
resource "docker_container" "app_staging" {
  name  = "app-staging"
  image = docker_image.flask_app.name

  ports {
    internal = 5000
    external = 5002
  }

  networks_advanced {
    name = docker_network.vnet_staging.name
  }

    env = ["ENVIRONMENT=staging"]

}

#development Environment
resource "docker_container" "app_dev" {
  name  = "app-dev"
  image = docker_image.flask_app.name

  ports {
    internal = 5000
    external = 5003
  }

  networks_advanced {
    name = docker_network.vnet_dev.name
  }

    env = ["ENVIRONMENT=dev"]

}


#Docker Networks
resource "docker_network" "vnet_prod" {
  name = "vnet-prod"
}

resource "docker_network" "vnet_staging" {
  name = "vnet-staging"
}

resource "docker_network" "vnet_dev" {
  name = "vnet-dev"
}
