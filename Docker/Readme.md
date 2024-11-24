https://rajeshsingamsetti.blogspot.com/2023/01/docker-pro-by-rajesh.html

Virtualization and Docker are essential technologies in modern IT infrastructure, but they work differently and serve distinct purposes. Let's break them down with a focus on **hypervisors** and **Docker**:

---

## **Virtualization with Hypervisors**

### **What is a Hypervisor?**
A **hypervisor** is software or firmware that allows multiple virtual machines (VMs) to run on a single physical machine. It abstracts the hardware resources (CPU, memory, storage, network) and allocates them to the VMs.

### **Types of Hypervisors**
1. **Type 1 (Bare-Metal Hypervisors):**
   - Runs directly on physical hardware.
   - Examples: VMware ESXi, Microsoft Hyper-V, KVM (Kernel-based Virtual Machine).

2. **Type 2 (Hosted Hypervisors):**
   - Runs on top of a host operating system.
   - Examples: VMware Workstation, VirtualBox.

### **Key Features**
- **Isolation:** Each VM is isolated with its own operating system.
- **Resource Allocation:** VMs have dedicated CPU, RAM, and storage.
- **Use Cases:** Running multiple OSes, testing, disaster recovery, and server consolidation.

---

## **Containerization with Docker**

### **What is Docker?**
Docker is a **containerization platform** that allows applications to run in isolated environments called containers. Unlike hypervisors, Docker uses the host's operating system kernel, making it lightweight and faster.

### **How Docker Differs from Hypervisors**
| Feature              | Hypervisors                          | Docker                                 |
|----------------------|-------------------------------------|---------------------------------------|
| **Architecture**     | Full virtualization with VMs. Each VM has its OS. | Containers share the host OS kernel. |
| **Performance**      | Heavier, slower startup (full OS boot). | Lightweight, fast startup.            |
| **Isolation**        | Strong, but resource-intensive.       | Moderate, uses namespaces and cgroups.|
| **Resource Usage**   | High (due to OS overhead).           | Low (uses host kernel).               |
| **Portability**      | VMs can be moved but are heavier.    | Containers are portable and lightweight. |

---

### **Key Features of Docker**
1. **Lightweight:** No need for a separate OS in each container.
2. **Fast Deployment:** Containers start in seconds.
3. **Portability:** Docker images can run anywhere with Docker installed.
4. **Microservices Architecture:** Ideal for deploying and managing microservices.

---

## **When to Use What?**
| Scenario                                  | Recommended Technology |
|------------------------------------------|-------------------------|
| Run multiple OSes on one physical machine | Hypervisor (Type 1 or 2)|
| Develop, test, and deploy microservices   | Docker                  |
| Legacy applications needing full OS access| Hypervisor              |
| Cloud-native application development      | Docker                  |
| Multi-tenancy with strong isolation needs | Hypervisor              |

---

### **Docker on a Hypervisor**
- Docker can run on a VM managed by a hypervisor, providing a hybrid model.
- Use this setup for scenarios like:
  - **On-premises deployments**: Use VMs for security and isolation, then run Docker for application containerization.
  - **Testing environments**: Run Docker inside lightweight VMs on your local machine.

---
**By using containers we can run our applications our own isolated environments with all the packaged information
Here's the requested information in a **Notepad table format** for easy reference:

```
Command             | Example                                       | Description                                                                   | Reference
--------------------|-----------------------------------------------|-------------------------------------------------------------------------------|------------------------
docker run          | docker run -d --name webserver -p 80:80 nginx | Creates and runs a new container from the Nginx image in detached mode.      | Docker run Documentation
docker run          | docker run -it ubuntu /bin/bash               | Creates and runs a new Ubuntu container interactively.                       | Docker run Documentation
docker exec         | docker exec -it webserver /bin/bash           | Executes a command in the running container's shell.                        | Docker exec Documentation
docker exec         | docker exec webserver nginx -t                | Checks Nginx configuration in the container.                                | Docker exec Documentation
docker ps           | docker ps                                     | Lists all running containers.                                               | Docker ps Documentation
docker ps           | docker ps -a                                  | Lists all containers, including stopped ones.                               | Docker ps Documentation
docker build        | docker build -t myapp:latest .                | Builds a Docker image from a Dockerfile.                                    | Docker build Documentation
docker build        | docker build --no-cache -t myapp:latest .     | Builds an image without cache for a fresh build.                            | Docker build Documentation
docker pull         | docker pull nginx                             | Downloads the latest Nginx image.                                           | Docker pull Documentation
docker push         | docker push username/myapp:latest             | Uploads an image to Docker Hub.                                             | Docker push Documentation
docker images       | docker images                                 | Lists all Docker images on the host.                                        | Docker images Documentation
docker images       | docker images nginx                           | Lists images with the repository name nginx.                                | Docker images Documentation
docker login        | docker login                                  | Logs in to a Docker registry.                                               | Docker login Documentation
docker logout       | docker logout                                 | Logs out from a Docker registry.                                            | Docker logout Documentation
docker search       | docker search nginx                           | Searches for images with the name nginx on Docker Hub.                      | Docker search Documentation
docker version      | docker version                                | Displays Docker version information.                                        | Docker version Documentation
docker info         | docker info                                   | Displays system-wide Docker information.                                    | Docker info Documentation
docker system       | docker system prune                           | Cleans up unused Docker data.                                               | Docker system Documentation
docker volume       | docker volume create myvolume                 | Creates a new Docker volume.                                                | Docker volume Documentation
docker container    | docker container ls -a                        | Lists all containers and their statuses.                                    | Docker container Documentation
docker network      | docker network create mynetwork               | Creates a custom Docker network.                                            | Docker network Documentation
docker logs         | docker logs webserver                         | Fetches the logs of a container.                                            | Docker logs Documentation
docker stop         | docker stop webserver                         | Stops a running container.                                                  | Docker stop Documentation
docker start        | docker start webserver                        | Starts a previously stopped container.                                      | Docker start Documentation
docker rm           | docker rm webserver                           | Removes a stopped container.                                                | Docker rm Documentation
docker rmi          | docker rmi nginx                              | Removes an unused Docker image.                                             | Docker rmi Documentation
docker commit       | docker commit webserver mynginx               | Creates a new image from a container's changes.                             | Docker commit Documentation
docker cp           | docker cp webserver:/var/log/nginx ./logs     | Copies files between a container and the host.                              | Docker cp Documentation
docker stats        | docker stats                                  | Displays resource usage statistics for running containers.                  | Docker stats Documentation
docker top          | docker top webserver                          | Displays running processes inside a container.                              | Docker top Documentation
docker inspect      | docker inspect webserver                      | Returns detailed configuration for a container.                             | Docker inspect Documentation
docker tag          | docker tag nginx myrepo/nginx:latest          | Tags an image with a new name.                                              | Docker tag Documentation
docker pause        | docker pause webserver                        | Pauses a running container.                                                 | Docker pause Documentation
docker unpause      | docker unpause webserver                      | Resumes a paused container.                                                 | Docker unpause Documentation
docker attach       | docker attach webserver                       | Attaches local streams to a running container.                              | Docker attach Documentation
docker export       | docker export webserver -o webserver.tar      | Exports a container's filesystem as a tar file.                             | Docker export Documentation
docker import       | docker import webserver.tar nginx-backup      | Creates an image from a tarball.                                            | Docker import Documentation
```

This table provides a compact overview of Docker commands, examples, descriptions, and references for documentation. Let me know if you need additional commands or a different format!


