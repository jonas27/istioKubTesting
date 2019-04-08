kubectl delete -f namespace.yaml --ignore-not-found && \
kubectl delete -f destRules.yaml && \
kubectl delete -f gateway.yaml && \
kubectl delete -f helloManifest.yaml
