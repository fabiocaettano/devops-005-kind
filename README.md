# devops-005-kubernetes

## Criar Pod

1. Criar cluster:
``` bash
kind create cluster --config=k8s/001-create-cluster.yaml --name=cluster-labs-kind
```

2. Ativar o cluster:
``` bash
kubectl cluster-info --context kind-fullcycle
```

3. Subir ambiente:
``` bash
cd app
. config.sh
```

4. Consultar Pod:
``` bash
kubectl get pods
```