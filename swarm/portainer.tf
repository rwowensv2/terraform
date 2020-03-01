provider "docker" {}

resource "docker_volume" "portainer_volume" {
  name = "portainer_data"
}

resource "docker_service" "portainer" {
  name = "portainer-service"

  task_spec {
    container_spec {
      image = "portainer/portainer:latest"
    
      mounts {
          target    = "/data"
          source    = "portainer_data"
          type      = "volume"
      }
    }

    placement {
      constraints = ["node.role==manager"]
    }
    
  }
  
  endpoint_spec {
    ports {
      target_port = "9000"
    }
  }
}