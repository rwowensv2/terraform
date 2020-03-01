provider "docker" {}
resource "docker_service" "portainer" {
  name = "portainer-service"

  task_spec {
    container_spec {
      image = "portainer/portainer:latest"
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