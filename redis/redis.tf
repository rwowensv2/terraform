provider "docker" {}
resource "docker_container" "redis" {
  name = "redis"
  image = "redis"

  ports {
    internal = "6379"
    external = "6379"
  }

# custom redis.conf
  upload {
    content = "./files/redis.conf"
    file = "/usr/local/etc/redis/redis.conf"
  }
# Persistant Storage
  volumes {
    volume_name = "redis_home"
    container_path = "/var/redis_home"
  }

}

