# Cluster Kubernetes

## Criar cluster Localmente

### Kind

Criar o cluster:
``` bash
kind create cluster --config=k8s/create-cluster-kind.yaml --name=cluster-labs
kubectl cluster-info --context kind-fullcycle
```
Consultar os nodes:
``` bash
kubectl get nodes
```

### K3D

Criar Cluster:
``` bash
k3d cluster create --servers 1 --agents 2 -p "8080:30000@loadbalancer"
kubectl cluster-info
```
Consultar os nodes:
``` bash
kubectl get nodes
```

## Criar cluster no Cloud Provider

### Digital Ocean

Provisionar com Terra Form:

``` bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

Consultar os nodes:
``` bash
kubectl get nodes
```

### 2. Mudar Contexto

Consultar nome dos clusters:

``` bash
kubectl config get-clusters
```

Alterar Contexto entre os clusters:

``` bash

```

Consultar os nodes:
``` bash
kubectl get nodes
```

