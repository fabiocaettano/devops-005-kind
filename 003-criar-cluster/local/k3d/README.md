# $${\color{Black} Cluster \space com \space K3D }$$

## $${\color{Red} Criar \space Cluster}$$

1. Criar Cluster:
``` bash
k3d cluster create --servers 1 --agents 2 -p "8080:30000@loadbalancer"
kubectl cluster-info
```
2. Consultar os nodes:
``` bash
kubectl get nodes
```


## $${\color{Red} Mudar \space Contexto}$$

1. Consultar nome dos clusters:

``` bash
kubectl config get-clusters
```

2. Alterar Contexto entre os clusters:

``` bash
$ kubectl config use-context nameCluster
```

3. Consultar os nodes:
``` bash
kubectl get nodes
```


