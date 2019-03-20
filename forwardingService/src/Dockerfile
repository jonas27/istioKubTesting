# GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o main
# microk8s.docker build . -t hello
# microk8s.kubectl expose deployment microbot --type=NodePort --port=80 --name=microbot-service

FROM alpine
EXPOSE 3001
COPY . .
CMD ["main/main"]