# $${\color{Black} Cluster \space com \space Kind }$$

## $${\color{Red} Criar \space Cluster}$$

1. Criar o cluster:
``` bash
cd local/kind
kind create cluster --config=k8s/create-cluster-kind.yaml --name=cluster-labs
kubectl cluster-info --context kind-fullcycle
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


