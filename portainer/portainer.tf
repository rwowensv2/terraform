provider "docker" {
  host = "ssh://user@somehost:22"

resource "docker_service" "portainer" {
  name = "portainer-service"

  task_spec {
    container_spec {
      image = "portainer/portainer:latest"

      mounts = [
        {
          target    = "/data"
          source    = "portainer_data"
          type      = "volume"
          read_only = false
        },
      ]
    }
  }

  placement {
   constraints = [
      "node.role==manager",
    ]
    }
  
  endpoint_spec {
    ports {
      target_port = "9000"
    }
  }
}
}
