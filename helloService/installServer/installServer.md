#!/bin/bash

# Important

Helm template creates NodePort use this command <br />
```
helm template install/kubernetes/helm/istio --name istio --namespace istio-system \
--set gateways.istio-ingressgateway.type=NodePort \
--set gateways.istio-egressgateway.type=NodePort > installIstio 

--set sidecarInjectorWebhook.enabled=fals \     --> supposed to help for sidecar injection but no
```


Foward
```
kubectl -n istio-system port-forward --address 0.0.0.0 \
$(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') \
9090:9090
```

look for istio proxy and pod stuff
```
kubectl describe pods hello 
```