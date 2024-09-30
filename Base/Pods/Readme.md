# Kubernetes Pod Management Guide

## Overview

A **Kubernetes pod** is a collection of one or more Linux containers, and it is the smallest deployable unit in Kubernetes. Pods are used to run a single container (which is more common), or multiple tightly coupled containers (an advanced use case). Each pod has its own network, storage, and namespace resources.

**Official Documentation:**
[Kubernetes Kubectl Cheatsheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

> **Note**: When a container is created inside a pod, it creates a volume known as `EmpDir` by default.

## Basic Pod Commands

### Create a Pod:
```bash
kubectl run nginxpod --image=nginx:latest
```

### Dry Run:
The `--dry-run` flag simulates the command without executing it.

**Example**:
```bash
kubectl run nginxpod --image=nginx:latest --dry-run=client
```

## YAML Declarative Approach

You can convert Kubernetes commands into YAML manifest files for a more declarative approach.

**Example**:
```bash
kubectl run nginxpod --image=nginx:latest --dry-run=client -o yaml
```

Sample output:
```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  name: nginx
  labels:
    run: nginx  
spec:
  containers:
  - image: nginx
    name: nginx
    ports:
    - containerPort: 80
  restartPolicy: Always
```

### Widely Used Pod Commands:

- **Get all namespaces:**
  ```bash
  kubectl get ns
  ```
- **Create a namespace:**
  ```bash
  kubectl create ns <namespace_name>
  ```
- **Get all pods in all namespaces:**
  ```bash
  kubectl get pods --all-namespaces
  ```
- **Create a pod using YAML:**
  ```bash
  kubectl create -f pod.yaml
  ```
- **Edit a pod:**
  ```bash
  kubectl edit pod <pod_name>
  ```
- **Delete a pod:**
  ```bash
  kubectl delete pod <pod_name>
  ```

## Monitoring and Scaling

### Get Kubernetes Events:
```bash
kubectl get events --watch &
```

### Scale a Deployment:

- **Scale to 2 replicas:**
  ```bash
  kubectl scale deployment hello-world --replicas=2
  ```
- **Scale down to 1 replica:**
  ```bash
  kubectl scale deployment hello-world --replicas=1
  ```

### Execute Commands in Pods

You can execute commands inside a running pod's container to inspect or debug.

**Example**:
```bash
kubectl exec -it <pod_name> -- /bin/sh
```
Once inside, you can list processes:
```bash
ps
exit
```

## Port Forwarding

You can forward a local port to a pod, allowing access to services running inside the pod from your local machine.

**Example**:
```bash
kubectl port-forward <pod_name> 80:8080
```

## Troubleshooting and Debugging

### Explain Pod Specifications:
```bash
kubectl explain pod.spec
kubectl explain pod.spec.containers
```

### Describe Pod Resources:
```bash
kubectl describe pod <pod_name>
```

### View Pod Logs:
```bash
kubectl logs <pod_name>
```
**Examples**:
- **View logs of a pod with multiple containers:**
  ```bash
  kubectl logs <pod_name> --all-containers=true
  ```

- **Stream logs of a specific container:**
  ```bash
  kubectl logs -f -c <container_name> <pod_name>
  ```

## Common Commands Summary

- **Generate YAML manifest from command:**
  ```bash
  kubectl run podname --image=yourimage:v1 --dry-run=client -o yaml
  ```

- **Execute a command inside a pod:**
  ```bash
  kubectl exec <pod_name> -- <command>
  ```

- **Port-forwarding to access pod services locally:**
  ```bash
  kubectl port-forward pod/<pod_name> 8080:80
  ```

This README provides a comprehensive guide to managing Kubernetes pods and their related commands, ensuring efficient pod creation, debugging, and troubleshooting.