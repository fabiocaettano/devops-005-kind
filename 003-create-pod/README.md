# devops-005-kubernetes

## Criar Pod


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

