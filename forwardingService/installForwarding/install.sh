kubectl apply -f destRules.yaml && \
kubectl apply -f gateway.yaml && \
kubectl apply -f forwardingManifest.yaml

kubectl delete -f destRules.yaml && \
kubectl delete -f gateway.yaml && \
kubectl delete -f forwardingManifest.yaml

test:
curl -o /dev/null -s -w "%{http_code}\n" http://0.0.0.0:31380/hello