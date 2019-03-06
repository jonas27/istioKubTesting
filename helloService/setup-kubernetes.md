# Install on server


1. For Kubernetes follow: 
  https://linuxconfig.org/how-to-install-kubernetes-on-ubuntu-18-04-bionic-beaver-linux
  
2. Add User to Kubeadm: 
  https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#more-information
  
1. Install network (flannel): 
  https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#pod-network
  
2. Install and Access Dashboard: 
  https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

1. Create User and get Token: 
  https://www.youtube.com/watch?v=aB0TagEzTAw
  * Create User with: 
    kubectl apply -f newUser
  * Get user token name: 
    kubectl  describe  sa admin-user -n kube-system | grep Tokens
  * Get token: kubectl describe secret admin-user-****
    kubectl describe secret admin-user-***-*** -n kube-system |grep token

1. Create Promotheus
  * install helm:
  sudo apt install snapd -y && sudo snap install helm --classic
    
```


Istio:
Download:
  https://istio.io/docs/setup/kubernetes/download-release/
Install with helm
  install helm with snap, then configure istio
  https://istio.io/docs/setup/kubernetes/helm-install/