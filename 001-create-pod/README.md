# devops-005-kubernetes

## Criar Pod

### 1. Criar cluster local ou no cloud provider

*Localmente com Kind:*
``` bash
kind create cluster --config=k8s/001-create-cluster.yaml --name=cluster-labs-kind
kubectl cluster-info --context kind-fullcycle
```

*Localmente com K3D:*
``` bash
```

*Cloud Provider na Digital Ocean:*
``` bash
```

Consultar os nodes:
``` bash
kubectl get nodes
```

### 2. Após criar o Cluster subir ambiente:
``` bash
cd app
. config.sh
```

### 3. Consultar Pod:
``` bash
kubectl get pods
```

### 4. Consultar Logs
``` bash
kubectl logs server
```

### 5. Acessar Pod:
``` bash
kubectl exec -it pod/server -- sh
```

### 6. Testar Pod:

``` bash
curl http://localhost:8080/configmap
```

### 7. Alterar Contexto entre os clusters:
``` bash

```