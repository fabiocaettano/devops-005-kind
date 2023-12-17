# POD

## Criar Pod

1. Após criar o Cluster subir ambiente:
``` bash
cd app
. config.sh
```

2. Consultar Pod:
``` bash
kubectl get pods
kubectl get pods o -wide
```

3. Consultar Logs
``` bash
kubectl logs server
```

4. Consultar informações do POD:
```
kubectl describe pod nomeDoPod
```

5. Acessar Pod:
``` bash
kubectl exec -it pod/server -- sh
```

5. Testar Pod:

``` bash
curl http://localhost:8080/configmap
```


