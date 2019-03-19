kubectl apply -f destRules.yaml && \
kubectl apply -f gateway.yaml && \
kubectl apply -f helloManifest.yaml

kubectl delete -f destRules.yaml && \
kubectl delete -f gateway.yaml && \
kubectl delete -f helloManifest.yaml

test:
curl -o /dev/null -s -w "%{http_code}\n" http://0.0.0.0:31380/hello