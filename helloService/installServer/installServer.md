#!/bin/bash

# Important

Helm template creates NodePort use this command <br />
```
helm template install/kubernetes/helm/istio --name istio --namespace istio-system \
--set gateways.istio-ingressgateway.type=NodePort \
--set gateways.istio-egressgateway.type=NodePort > installIstio 

--set sidecarInjectorWebhook.enabled=fals2 \     --> supposed to help for sidecar injection but no
```


Foward <br /> 
Prom 
```
kubectl -n istio-system port-forward --address 0.0.0.0 \
$(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') \
9090:9090 & > promForward
```
Graf 
```
kubectl -n istio-system port-forward --address 0.0.0.0 \
$(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') \
3000:3000 & > grafForward
```
Jaeger 
```
kubectl -n istio-system port-forward --address 0.0.0.0 \
$(kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}') \
16686:16686 & > jaegerForward
```
Service Graph
```
kubectl -n istio-system port-forward --address 0.0.0.0 \
$(kubectl -n istio-system get pod -l app=servicegraph -o jsonpath='{.items[0].metadata.name}') \
8088:8088 & > serviceGraphForward
```



look for istio proxy and pod stuff
```
kubectl describe pods hello 
```

normal bookinfo install does not install promotheus dependencies. no its running