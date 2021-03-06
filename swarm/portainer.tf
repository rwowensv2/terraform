provider "docker" {}

resource "docker_volume" "portainer_volume" {
  name = "portainer_data"
}
resource "docker_network" "port-network" {
  name    = "portainer_agent_network"
  driver  = "overlay"
}

resource "docker_network" "traefik" {
  name    = "traefik-net"
  driver  = "overlay"
}

resource "docker_service" "portainer_agent" {
  name = "portainer-agent"

  task_spec {
    container_spec {
      image = "portainer/agent:latest"

      mounts {
        target    = "/var/run/docker.sock"
        source    = "//var/run/docker.sock"
        type      = "bind"
      }

      mounts {
        target    = "/var/lib/docker/volumes"
        source    = "//var/lib/docker/volumes"
        type      = "bind"
      }

    }
  networks     = ["${docker_network.port-network.id}"]
  }
mode {
    global = true
  }
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

      mounts {
          target    = "/var/run/docker.sock"
          source    = "/var/run/docker.sock"
          type      = "bind"
      }
      
      command  = ["/portainer"]
      args     = ["-H tcp://tasks.portainer_agent:9001 --tlsskipverify"]
    }  
    placement {
      constraints = ["node.role==manager"]
    }
    networks = ["${docker_network.port-network.id}","${docker_network.traefik.id}"]
  }
  
  endpoint_spec {
    ports {
      target_port     = "9000"
      published_port  = "9000"
    }

    ports {
      target_port     = "8000"
      published_port  = "8000"
    }
  }
}
