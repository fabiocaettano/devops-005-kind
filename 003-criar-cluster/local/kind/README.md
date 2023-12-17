# $${\color{Black} Criar \space Cluster \space com \space Kind }$$


Criar o cluster:
``` bash
cd local/kind
kind create cluster --config=k8s/create-cluster-kind.yaml --name=cluster-labs
kubectl cluster-info --context kind-fullcycle
```
Consultar os nodes:
``` bash
kubectl get nodes
```

