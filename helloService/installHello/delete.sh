kubectl delete -f helloManifest.yaml
kubectl delete -f destRules.yaml
kubectl delete -f gateway.yaml
kubectl delete -f namespace.yaml --ignore-not-found
