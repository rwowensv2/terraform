provider "docker" {}
resource "docker_container" "portainer" {
  name = "portainer"
  image = "portainer/portainer:latest"

  ports {
    internal = "9000"
    external = "9000"
  }
 
  ports {
    internal = "8000"
    external = "8000"
  }

  volumes {
    volume_name = "portainer_home"
    container_path = "/data"
  }

}
