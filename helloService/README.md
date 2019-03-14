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
microk8s.docker build -t 5.189.132.161:5000/hello: .

This step is not needed:
(microk8s.docker tag hello localhost:32000/hello)
microk8s.docker push localhost:32000/hello:latest

curl --cacert domain.crt http://localhost:32000/v2/_catalog
curl --cacert domain.crt http://5.189.132.161:5001/v2/_catalog
```

### Kubernetes && Istio
```
microk8s.enable dns dashboard ingress storage istio registry metrics-server prometheus fluentd jaeger

microk8s.kubectl create -f manifest.yaml 
microk8s.kubectl delete -f manifest.yaml 

# list all 
microk8s.kubectl get all --all-namespaces

microk8s.kubectl describe pods

microk8s.kubectl label namespace default istio-injection=enabled

microk8s.kubectl get destinationrules -o yaml
microk8s.kubectl create -f routetrule.yaml 

microk8s.kubectl -n istio-system port-forward istio-ingressgateway-89c5bd64f-89zq6 2000

# Forward ingress
microk8s.kubectl get pod -n istio-system -l istio=ingressgateway -o name
microk8s.kubectl -n istio-system port-forward istio-ingressgateway-89c5bd64f-89zq6 2000


kubectl edit service istio-ingressgateway -n istio-system



```

### Kubernetes Cheat Sheet
- **Pods**: are the smalles unit in Kubernetes and can contain multiple containers.<br />
However, only containers which scale together should be together.<br />
Always ask yourself "Do the containers care on which server they are running?". <br />
If the answer is no, then they should not be in a Pot together.

- **Manifest**: should be treated as source code with comments for explanation. <br />

- **Namespaces**: Are Virtual Clusters inside one physical cluster. [more info here](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)

- **HealthChecks**: By default, Kubernetes checks if the main process is running, and (re)starts it if necessary. <br >
However, it is more sensible to implement a health check incorporating deadlocks etc. <br />
This is called health checks for application *liveness* and are defined in the manifest. <br />
Kubernetes also supports tcp health checks and *exec* probes, executing a script inside the container<br />
If the script returns a non-zero code the container is not healthy.

- **Readiness**: Check when a container is ready for requests.

- **Volumes**: Are defined for a Pod and then on a container basis.<br />
Only containers which need a volume should have access and volumes can be shared across containers. 

- **DNS**: address inside a namespace is just normal service name, outside namespace, the namespace needs to be referenced as well [here](https://kubernetes.io/docs/concepts/services-networking/service/#dns)

- **Istio Requirements**: Istio requirements can be found [here](https://istio.io/docs/setup/kubernetes/spec-requirements/).
    - Versions are important for Istio to route traffic and are a requirement when running on Kubernetes. <br />

## Kinds
- **Deployment**: Meant to replace *Replica Controller* as it provides more functions. <br />


## Bugs:
- **FROM SCRATCH**: Do not use Scratch only Alpine as scratch has no sh.

- **Connection Refused**: use following commands to turn of swap and
```
  sudo swapoff -a
  sudo strace -eopenat kubectl version
```

- **Dashboard error**: After reboot dashboard does not start
```
    sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```

get istio stuff
```
kubectl get events --namespace=istio-system
```

to deploy on single node master
kubectl taint nodes --all node-role.kubernetes.io/master-

$(kubectl get po -l istio=ingressgateway -n istio-system -o 'jsonpath={.items[0].status.hostIP}'):$(kubectl get svc istio-ingressgateway -n istio-system -o 'jsonpath={.spec.ports[0].nodePort}')

minikube start --memory=8192 --cpus=4 --kubernetes-version=v1.10.0 \
    --extra-config=controller-manager.cluster-signing-cert-file="/var/lib/localkube/certs/ca.crt" \
    --extra-config=controller-manager.cluster-signing-key-file="/var/lib/localkube/certs/ca.key" \
    --vm-driver=`virtualbox`