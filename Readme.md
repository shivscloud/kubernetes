---

# Kubernetes Core Concepts and Components

![Kubernetes Architecture](https://www.reddit.com/media?url=https%3A%2F%2Fi.redd.it%2Fcqud3rjkss361.png)

Control plane:
Ref: https://www.rajesh-singamsetti.site/2024/07/kubernetes-e2e-advanced.html
- API(Run as a pod)
- Scheduler(Run as a pod)
- Control manager(Run as a pod)
- ETCD(Run as a pod)
Data plane:
Ref:- https://www.rajesh-singamsetti.site/2024/07/kubernetes-e2e-advanced.html
- Kubelet(Run as a Daemonset) -- 
- Kube Proxy(Run as a pod)

---

This guide provides a comprehensive overview of essential Kubernetes components. Understanding these concepts is crucial for building, deploying, and maintaining containerized applications using Kubernetes.

---

## 🧑‍💻 Core Concepts

---

### **Pod**
The smallest and simplest Kubernetes object, representing a set of running containers in your cluster.
CSI : Container Storage Interface
CNI: Container Network Interface
- **Sidecar Container**: A helper container in a Pod that enhances or provides additional functionality to the main container.
- **Init Container**: A special container that runs before the main application container in a Pod to perform setup tasks.

---

### **ReplicaSet (RS)**
Ensures that a specified number of pod replicas are running at any given time, maintaining the desired state.

---

### **ReplicationController (RC)**
Similar to ReplicaSet but with older, less flexible functionality. It ensures a specified number of pod replicas are operational.

---

### **Deployment**
Provides declarative updates for Pods and ReplicaSets, describing an application’s lifecycle, including image usage, pod replicas, and update strategy.

---

### **StatefulSet**
Manages the deployment and scaling of a set of Pods, providing ordering and uniqueness guarantees. It is primarily used for stateful applications where the identity of the Pods is significant.

---

### **DaemonSet**
Ensures that all (or some) nodes run a copy of a Pod, automatically adding Pods as nodes are added to the cluster.

---

### **Job**
Creates one or more Pods and ensures a specified number of them successfully terminate, often used for batch processing.

---

### **CronJob**
Manages time-based job scheduling, similar to Unix cron jobs. It is useful for periodic tasks like backups or report generation.

---

### **Service**
Exposes an application running on a set of Pods as a network service, abstracting communication details.

---

### **Ingress**
Manages external access to services in a cluster, typically over HTTP, providing load balancing, SSL termination, and name-based virtual hosting.

---

### **ConfigMap**
Injects non-sensitive configuration data into applications, allowing for decoupling configuration artifacts from container images.

---

### **Secret**
Stores and manages sensitive information such as passwords, OAuth tokens, and SSH keys, facilitating secure data sharing with the Pods.

---

### **Volume**
Manages data storage for containers in a Pod, with support for various types of volumes (e.g., emptyDir, hostPath, NFS).

---

### **PersistentVolume (PV)**
Provisioned storage that exists independently of Pods, serving as resources within the cluster.

---

### **PersistentVolumeClaim (PVC)**
A user request for storage resources, allowing dynamic allocation by referencing available PersistentVolumes.

---

### **StorageClass**
Defines different classes of storage (e.g., SSD, HDD) and enables dynamic provisioning of volumes.

---

### **Namespace**
Scopes resources within a cluster, providing a mechanism for isolating and organizing resources.

---

### **Node**
A worker machine in Kubernetes (either a VM or physical machine) where Pods are scheduled and run.

---

### **Label**
Key/value pairs attached to Kubernetes objects for organization and selection purposes.

---

### **Annotation**
Metadata attached to objects that can hold arbitrary, non-identifying data for use by external tools or applications.

---

### **Controller**
A control loop that watches the state of the cluster through the API server, making changes to move the current state towards the desired state.

---

### **Node Affinity**
Constrains Pod placement on specific nodes based on their labels, offering a more advanced and flexible alternative to node selectors.

---

## 🩺 Probes

---

Kubernetes uses probes to check the health of containers and ensure they are functioning correctly.

- **Liveness Probe**: Checks if the container is running. If it fails, Kubernetes restarts the container.
- **Readiness Probe**: Checks if the container is ready to handle requests. A container that fails this probe is temporarily removed from service endpoints until it recovers.
- **Startup Probe**: Checks if the application within the container has started, particularly useful for containers with slow startup times.

---

## 🚀 Control Plane Components

---

### **kube-apiserver**
Exposes the Kubernetes API and acts as the front-end for the Kubernetes control plane.

---

### **etcd**
A distributed key-value store that serves as Kubernetes' backing store for all cluster data.

---

### **kube-scheduler**
Selects nodes for newly created Pods based on resource availability and constraints.

---

### **kube-controller-manager**
Runs various controller processes to regulate and maintain the state of the cluster.

---

### **cloud-controller-manager**
Manages controllers that interact with cloud providers, enabling cloud-specific operations like load balancer provisioning.

---

## 🖥️ Node Components

---

### **kubelet**
An agent that runs on each node, ensuring that containers are running in Pods as expected.

---

### **kube-proxy**
Maintains network rules on nodes to allow network communication to Pods, supporting Kubernetes service mechanisms.

---

### **Container Runtime**
The software responsible for running containers, such as Docker, containerd, or CRI-O.

---

## 📈 Additional Components

---

### **Horizontal Pod Autoscaler (HPA)**
Automatically scales the number of Pods in a deployment based on observed CPU utilization or other custom metrics.

---

### **Vertical Pod Autoscaler (VPA)**
Adjusts resource requests and limits for containers based on historical usage.

---

### **Custom Resource Definition (CRD)**
Extends Kubernetes' capabilities by allowing users to define their own API objects.

---

### **Operator**
A Kubernetes pattern that automates the packaging, deployment, and management of applications using custom resources and controllers.

---

## 🔐 RBAC Components

---

### **Role**
Defines permissions for a namespace, allowing fine-grained control over access to resources.

---

### **ClusterRole**
Similar to Role, but permissions are cluster-wide rather than restricted to a specific namespace.

---

### **RoleBinding**
Grants permissions defined in a Role to a user or group within a namespace.

---

### **ClusterRoleBinding**
Grants cluster-wide permissions defined in a ClusterRole to a user or group.

---

## 🛠️ Service Types

---

### **ClusterIP**
Exposes a service on a cluster-internal IP, accessible only within the cluster.

---

### **NodePort**
Exposes a service on each node's IP at a static port, enabling external access to the service.

---

### **LoadBalancer**
Exposes the service externally using a cloud provider's load balancer, making it accessible over the internet.

---

### **Headless Service**
Does not assign a cluster IP to the service, primarily used for service discovery where DNS is sufficient.

---

## 🔒 Network Policies

---

### **NetworkPolicy**
Controls the flow of traffic to and from Pods, defining which traffic is allowed or denied.

---

## 🧰 Admission Controllers

---

### **MutatingAdmissionWebhook**
Alters requests before they are persisted in the cluster, enabling custom modifications to resources upon creation or updates.

---

### **ValidatingAdmissionWebhook**
Validates incoming requests to ensure compliance with the cluster's policy before persistence.

---

## 🌀 Miscellaneous

---

### **PodDisruptionBudget (PDB)**
Specifies the minimum or maximum number of Pods that must remain available during voluntary disruptions (e.g., rolling updates).

---

### **LimitRange**
Enforces minimum and maximum resource usage (like CPU and memory) for objects in a namespace.

---

### **ResourceQuota**
Manages resource quotas within a namespace, ensuring that teams do not exceed allocated resources.

---

### **EndpointSlice**
Stores the addresses of endpoints for a service, improving scalability and performance over the older `Endpoints` resource.

---

### **PriorityClass**
Defines the priority of Pods, influencing scheduling decisions during resource contention.

---

### **RuntimeClass**
Specifies the container runtime to be used for Pods, allowing customization of container execution.

---

### **ServiceAccount**
Provides an identity for processes running in Pods, used for authentication and authorization within the Kubernetes API.

---

### **Lease**
Represents a lease object that can be utilized for resource coordination, such as leader election in high-availability applications.

---

### **PodSecurityPolicy (PSP)**
Controls security-sensitive aspects of pod specification, enabling cluster administrators to enforce security policies.

---

### **VolumeSnapshot**
Provides a way to take snapshots of PersistentVolumes, enabling backup and recovery functionalities.

---

### **CNI (Container Network Interface)**
Standard for configuring network interfaces in Linux containers, allowing Kubernetes to manage networking.

---

### **CSI (Container Storage Interface)**
Standard for exposing block and file storage systems to containerized workloads on Kubernetes.

---

## 📚 **Conclusion**

---

Mastering these core components is essential for effective Kubernetes usage. Understanding how each piece fits into the larger ecosystem empowers you to design, manage, and optimize your Kubernetes clusters efficiently.

Explore each concept in depth and engage in hands-on experimentation to solidify your knowledge!

---

Happy Learning! 🚀

--- 

