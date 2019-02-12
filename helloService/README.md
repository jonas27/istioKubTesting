#istioKubTesting


Before starting the work you have to enable the istio-injection by executing the command
```kubectl label namespace default istio-injection=enabled --overwrite```

### Build && Docker
```
CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -a -installsuffix cgo -o main .
GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o main .
sudo docker build . -t hello
sudo docker run -p 3000:3000 hello
microk8s.docker build . -t hello
microk8s.docker build -t localhost:32000/hello:latest .
This step is not needed:
(microk8s.docker tag hello localhost:32000/hello)
microk8s.docker push localhost:32000/hello:latest

curl --cacert domain.crt http://localhost:32000/v2/_catalog
```

### Kubernetes && Istio
```
microk8s.enable dns dashboard ingress storage istio registry metrics-server prometheus fluentd jaeger

microk8s.kubectl create -f manifest.yaml 
microk8s.kubectl delete -f manifest.yaml 


microk8s.kubectl describe pods

microk8s.kubectl label namespace default istio-injection=enabled

```

### Kubernetes Cheat Sheet
- **Pods**: are the smalles unit in Kubernetes and can contain multiple containers.<br />
However, only containers which scale together should be together.<br />
Always ask yourself "Do the containers care on which server they are running?". <br />
If the answer is no, then they should not be in a Pot together.

- **Manifest**: should be treated as source code with comments for explanation. <br />

- **HealthChecks**: By default, Kubernetes checks if the main process is running, and (re)starts it if necessary. <br >
However, it is more sensible to implement a health check incorporating deadlocks etc. <br />
This is called health checks for application *liveness* and are defined in the manifest. <br />
Kubernetes also supports tcp health checks and *exec* probes, executing a script inside the container<br />
If the script returns a non-zero code the container is not healthy.

- **Readiness**: Check when a container is ready for requests.

- **Volumes**: Are defined for a Pod and then on a container basis.<br />
Only containers which need a volume should have access and volumes can be shared across containers. 


- **Versions**: Versions are important for Istio to route traffic and are a requirement when running on Kubernetes [ref online](https://istio.io/docs/setup/kubernetes/spec-requirements/). <br />


## Kinds
- **Deployment**: Meant to replace *Replica Controller* as it provides more functions. <br />


## Bugs:
- **FROM SCRATCH**: Do not use Scratch only Alpine as scratch has no sh.