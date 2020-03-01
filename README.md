# Terraform

```
terraform plan     # list changes needed
terraform apply    # launch containers 
terraform destroy  # cleanup
terraform validate # validate tf file
terraform init     # init plugins ./.terraform
```

## Using

Initialize Modules
```
sudo erraform init
```

Validate
```
terraform validate
```

Apply (Start)
```
sudo terraform apply
```

## Jenkins
After start grab the initial password.  
```
$ docker container ls
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                                              NAMES
5dc9d9597093        jenkins/jenkins:lts   "/sbin/tini -- /usr/…"   2 minutes ago       Up 2 minutes        0.0.0.0:8080->8080/tcp, 0.0.0.0:50000->50000/tcp   jenkins

$ docker exec 5dc9d9597093 cat /var/jenkins_home/secrets/initialAdminPassword
1346c41841194e37ae731effaeb9839e
```

# Portainer
`docker stack deploy --compose-file=portainer-agent-stack.yml portainer`