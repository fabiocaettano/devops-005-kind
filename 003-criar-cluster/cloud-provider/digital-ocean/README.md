# $${\color{Black} Criar \space Cluster \space com \space a \space Digital \space Ocean }$$

## $${\color{Red} Provisionar \space Cluster}$$

1. Provisionar máquina com terraform:
``` bash
$ cd terraform/droplet
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

4. Consultar se o config existe na máquina remota
``` bash
ls -la ~/.kube
```
5. Se não existir:
``` bash
mkdir .kube
touch ~/.kube/config
```

6. Atualizar o arquivo:
``` bash
cat cluster-devops-005-kubeconfig.yaml >> /root/.kube/config
```

7. Consultar os nodes:
``` bash
kubectl get nodes
```


## $${\color{Red} Mudar \space Contexto}$$

1. Consultar nome dos clusters:

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


