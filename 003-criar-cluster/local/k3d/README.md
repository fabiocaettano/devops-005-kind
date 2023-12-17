# $${\color{Black} Criar \space Cluster \space com \space K3D }$$

Criar Cluster:
``` bash
k3d cluster create --servers 1 --agents 2 -p "8080:30000@loadbalancer"
kubectl cluster-info
```
Consultar os nodes:
``` bash
kubectl get nodes
```
