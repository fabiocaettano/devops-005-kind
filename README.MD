# <h1>Criar Cluster</h1>

Sumário
- [1.0 Cloud Provider](#20-cloud-provider)
     [1.1 Digital Ocean](#21-digital-ocean)
- [2.0 Local](#30-local)
    [2.1 Kind](#31-kind)
    [2.2 K3d](#32-k3d)
- [3.0 Mudar de Contexto](#30-mudar-contexto)

## <h2>1.0 Cloud Provider </h2>

### <h3>1.1 Digital Ocean</h3>

1. Provisionar cluster com terraform:
``` bash
$ cd terraform/
$ terraform init
$ terraform plan -out=infra.out
$ terraform apply "infra.out"
```

2. Acessar o site da Digital Ocean na opção **Manage >> Kubernetes >> Clicar em ... >> Download Config**.

3. Copiar o arquivo da máquina local para máquina remota:
``` bash
scp /mnt/c/Users/fabio/Downloads/cluster-devops-005-kubeconfig.yaml root@ipDaMaquinaVirtual:/root
cluster-devops-005-kubeconfig.yaml
```

4. O contéudo do arquivo **cluster-devops-005-kubeconfig.yaml** deve ser inserido no arquivo **~/.kube/config** da máquina remota.

5. Consultar se o config existe na máquina remota
``` bash
ls -la ~/.kube
```
6. Se não existir:
``` bash
mkdir .kube
touch ~/.kube/config
```

7. Atualizar o arquivo:
``` bash
cat cluster-devops-005-kubeconfig.yaml >> /root/.kube/config
```

8. Consultar os nodes:
``` bash
kubectl get nodes
```

## <h2>2.0 Local</h2>

### <h3>2.1 Kind</h3>

### <h3>2.2 K3d</h3>


## <h2>3.0 Mudar Contexto</h2>

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

