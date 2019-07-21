provider "docker" {}
resource "docker_container" "jenkins" {
  name = "jenkins"
  image = "jenkins/jenkins:lts"

  ports {
    internal = "50000"
    external = "50000"
  }
 
  ports {
    internal = "8080"
    external = "8080"
  }

  volumes {
    volume_name = "jenkins_home"
    container_path = "/var/jenkins_home"
  }

}
