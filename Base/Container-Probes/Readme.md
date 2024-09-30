Ref: https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/ 

https://learnk8s.io/sidecar-containers-patterns

In Kubernetes, a sidecar container is a container that starts before the main application container and continues to run. This document is about init containers: containers that run to completion during Pod initialization



Sidecar Containers:

- Init Containers
- Adapter Containers
- Ambassador Containers
Probes:
 Rediness Probe (It decide when to start and stop to sending the traffic to pod)
Liveness probe (When to restart the container)
Startup probe: For huge dependency application which need to be run before R & L Probes
 --------------------------------------------------------------------------------------------------------------

In POD inside along with main container we can kept the one more helper container that we can called as the sidecar container.

* to send the logs from main container also we are using side-car container.

--------------------------------------------------Init container-------------------------------------------------

Init containers allow you to separate your application from the initialization logic and provide a way to run the initialization tasks such as setting up permissions, database schemas, or seeding data for the main application, etc. The init containers may also include any tools or binaries that you don't want to have in your primary container image due to security reasons.



A Pod can have multiple containers running apps within it, but it can also have one or more init containers, which are run before the app containers are started.

Init containers are exactly like regular containers, except:

Init containers always run to completion.

Each init container must complete successfully before the next one starts

Real time example:

https://github.com/shivscloud/k8-s/blob/main/dep-svc-sidecarinit-probes/dep-svc-init.yml

In same K8 manifest the postgres-service is running on port 5432

Now our flask pod will wait until the postgress container will up and running



To run the k8 manifest
kubectl apply -f k8-manifest.yml

to login to the postgress pod & to check the tables

kubectl exec -it postgres-deployment-7ddfc5559d-99qfv -- psql -U myuser -d mydatabase

* to view the database:
\dt

* to view the tables part of database:
SELECT * FROM users;

* optional: to run only Pod for trouble-shoot.
kubectl run -it --rm --image=rajeshsingam/prod-working-flask:latest my-flask-app --env="DATABASE_URL=postgresql://myuser:mypassword@postgres-service:5432/mydatabase" -- bash

If any issues in pod:
kubectl logs pod-name
kubectl logs  postgres-deployment-ff9f9bbdc-b6vx8 -c init-db

kubectl describe pod pod-name


If you want access the app:
Via minikube: minikube service flask-service
Via AWS lb : use nodeport and deploy the manifest

# flask-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: flask-service
spec:
  type: NodePort # else you can use load balancer with ingress  
  selector:
    app: flask
  ports:
    - protocol: TCP
      port: 5000
      targetPort: 5000

--------------------------------------------------Adapter container-------------------------------------------------

Ref: https://itnext.io/4-container-design-patterns-for-kubernetes-a8593028b4cd
https://www.weave.works/blog/kubernetes-patterns-the-adapter-pattern

An adapter container in Kubernetes is often used in the context of the sidecar pattern. The sidecar pattern involves attaching additional containers to the main application container to extend or enhance its functionality. An adapter container, in this context, is a container that performs some auxiliary function or provides additional capabilities to the main application.

The adapter container pattern is suitable when we want to keep the communication between containers consistent. It generally transforms the primary container's output into the output that fits our applications’ standards. For example, an adaptor container can expose our application's monitoring interface even though it does not implement it in a standard way. In Adapter Pattern, we can easily replace the existing container without affecting the application container because of just the configuration changes. This container's main benefit is that the adapter pattern enables a container to reuse a common system problem.

To monitor a pod we need to install:
pip install Flask prometheus-flask-exporter (in python flask app)


To rewrite the logs of main container to the monitoring tools like Prometheus the adapter container will play the main role.

# pod-with-adapter-container.yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: flask-container
    image: your-flask-image:latest
    ports:
    - containerPort: 5000
  - name: prometheus-adapter
    image: prom/prometheus:v2.26.0
    ports:
    - containerPort: 9090
---
# service-for-flask-container.yaml
apiVersion: v1
kind: Service
metadata:
  name: flask-service
spec:
  selector:
    app: my-pod
  ports:
  - protocol: TCP
    port: 5000
    targetPort: 5000
---
# service-for-prometheus-adapter.yaml
apiVersion: v1
kind: Service
metadata:
  name: prometheus-adapter-service
spec:
  selector:
    app: my-pod
  ports:
  - protocol: TCP
    port: 9090
    targetPort: 9090


in above example if we see single pod but one container running for the main application & one more container used to send the logs to monitor tools 
---------------------------------------Ambassador Containers--------------------------------------------
Ref: https://www.weave.works/blog/kubernetes-patterns-the-ambassador-pattern
The ambassador container pattern aims to hide the primary container's complexity and provide a unified interface through which the primary container can access services outside of the Pod.

Are there any other container patterns you ran into when working with Kubernetes?

"A container that proxy the network connection to the main container."

==========================Probes==========================

Ref Example:

https://github.com/shivscloud/k8-s/blob/main/dep-svc-sidecarinit-probes/probes.yml

https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

Readyness probe support: exec,tcpsocket,http

exec:
    command:
    - cat
    - /tmp/healthy
  initialDelaySeconds: 5
  periodSeconds: 5

readinessProbe:
      tcpSocket:
        port: 8080
      initialDelaySeconds: 15
      periodSeconds: 10
readinessProbe:
              httpGet:
                path: /index.html
                port: 5000
              initialDelaySeconds: 10 #it will wait for 10 seconds
              periodSeconds: 5 # it will check for each 5 seconds 
              timeoutSeconds: 3 # If something not working it will wait for 3 seconds
              successThreshold: 1
              failureThreshold: 3 # if it fail continious 3 times the readinessProbe won't send the traffic to pod
Now to test the readiness probe i logged into the pod and delete the index.html in pod

#for windows machine exec into pod

winpty kubectl.exe exec -it nginx-deployment-7c79c4bf97-kw84v  -- /usr/share/nginx/html/index.html

#for linux

kubectl exec -it pod nginx-deployment-7c79c4bf97-kw84v --bash  /usr/share/nginx/html/index.html



Now going to login to the pod & adding index.html manually



**But the problem with readiness is its not auto healing i.e its not able to resolve issue in automatic way



-------------------Liveness probe: 
It have a capability to auto restart the pod

Note: when readyness & liveness both are there u must increate *2 the "initialDelaySeconds" compare to readyness probe.

After adding liveness probe for one the pod i deleted the index.html now liveness probe trying to restart the pod 


After few sec restarting:


When it restarted a fresh build taking from deployment and pod running successfully
Events:
  Type     Reason     Age                   From               Message
  ----     ------     ----                  ----               -------
  Normal   Scheduled  7m4s                  default-scheduler  Successfully assigned default/nginx-deployment-79bf4977f6-558sd to minikube
  Normal   Pulled     6m58s                 kubelet            Successfully pulled image "nginx:latest" in 3.668s (3.668s including waiting)
  Warning  Unhealthy  4m9s (x3 over 4m19s)  kubelet            Liveness probe failed: HTTP probe failed with statuscode: 404
  Warning  Unhealthy  4m9s (x4 over 4m19s)  kubelet            Readiness probe failed: HTTP probe failed with statuscode: 404
  Normal   Killing    4m9s                  kubelet            Container nginx failed liveness probe, will be restarted
  Normal   Pulling    4m8s (x2 over 7m2s)   kubelet            Pulling image "nginx:latest"
  Normal   Created    4m5s (x2 over 6m58s)  kubelet            Created container nginx
  Normal   Pulled     4m5s                  kubelet            Successfully pulled image "nginx:latest" in 3.62s (3.62s including waiting)
  Normal   Started    4m4s (x2 over 6m58s)  kubelet            Started container nginx



*****Always remember while giveing timing seconds need to take care of seconds else it will go loop manner

Intial delay seconds: always liveness more than readiness probe seconds

-------------------------------------Startup probe:

for big application if there is any dependency while loading it hold the time to complete then it will allow R & L probe to run

The kubelet uses startup probes to know when a container application has started. If such a probe is configured, liveness and readiness probes do not start until it succeeds, making sure those probes don't interfere with the application startup. This can be used to adopt liveness checks on slow starting containers, avoiding them getting killed by the kubelet before they are up and running.

startupProbe: # for big application if there is any dependency while loading it hold the time to complete then it will allow R & L probe to run
              httpGet:
                path: /index.html
                port: 80
              initialDelaySeconds: 20 #it will wait for 10 seconds
              periodSeconds: 5 # it will check for each 5 seconds 
              timeoutSeconds: 3 # If something not working it will wait for 3 seconds
              successThreshold: 1
              failureThreshold: 3 # if it fail continious 3 times the readinessProbe won't send the traffic to pod         



