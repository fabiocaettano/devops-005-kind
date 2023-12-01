# devops-005-kind
Kubernetes curso FullCycle

- [Provisionar Máquina Virtual (Droplet)](#provisionar-máquina-virtual-droplet)
- [Configurar Ambiente](#configurar-ambiente)
    - [Máquina Local](#máquina-local)
    - [Chave SSH](#chave-ssh)
- [Criar e Deletar Cluster](#criar-e-deletar-cluster)
- [Criar Nodes](#criar-nodes)
- [Chavear Clusters](#chavear-clusters)
- [App Para Aplicar os Conceitos](#app-para-aplicar-os-conceitos)


## Provisionar Máquina virtual (Droplet)

Confugaração do Droplet:


Provisionar:

```bash
terraform apply -auto-approve
```

## Configurar Ambiente com Ansible

###  Máquina Local

1. Configurar o arquivo de inventário:
``` ini

```

2. Instalar Kubectl:
``` bash
#ativar o agent ssh
ssh-agent bash
ssh-add ~/.ssh/chaveSSH
#executar manifesto
ansible-playbook apply -i hosts/inventory.ini playbook/collections/kubectl.yaml
```
3. Instalar Docker:
``` bash
#ativar o agent ssh
ssh-agent bash
ssh-add ~/.ssh/chaveSSH
#executar manifesto
ansible-playbook apply -i hosts/inventory.ini playbook/collections/docker.yaml
```
4. Instalar Kind:
``` bash
#ativar o agent ssh
ssh-agent bash
ssh-add ~/.ssh/chaveSSH
#executar o manifesto
kubectl apply -i hosts/inventory.ini playbook/collections/kind.yaml
```

### Chave SSH

Enviar chave SSH da máquina local para o Droplet.

``` bash
scp /home/user/.ssh/nomeDaChave root@ipDaMaquinaVirtual:/root/.ssh/nomeDaChave
scp /home/user/.ssh/nomeDaChave.pub root@ipDaMaquinaVirtual:/root/.ssh/nomeDaChave.pub
```

### Maquina Virtual (Droplet)

1. Acessar máquina virtual:
``` bash
#ativar o agent ssh
ssh-agent bash
ssh-add ~/.ssh/chaveSSH
#executar o mesmo
ssh root@ipDaMáquinaVirual
```

2. Clonar projeto:
``` bash
git clone
```

3. Configurar usuário git:
``` bash

```




## Criar e Deletar Cluster

Criar o primeiro cluster:
``` bash
kind create cluster
```

Ativar o cluster:
``` bash
kubectl cluster-info --context kind-kind
```

Consultar Docker:
``` bash
docker ps
```

Checar os nodes:
```  bash
kubectl get nodes
```

Consultar o clusters:
``` bash
kind get clusters
```

Deletar o cluster:
``` bash
kind delete clusters kind
```

## Criar Nodes

Criar um cluster com 1 control pane e 3 worker nodes utilizando um arquivo de manifesto.
``` yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker
```

Para aplicar esta configuração:
``` bash
kind create cluster --config=001-create-cluster.yaml --name=fullcycle
```

Ativar:
``` bash
kubectl cluster-info --context kind-fullcycle
```

Checar os nodes:
``` bash
kubectl get nodes
```

## Chavear Clusters

Consultar clusters:
``` bash
kubectl config get-clusters
```
Consultar Nodes:
``` bash
kubectl get nodes
```
Para chavear 
``` bash
kubectl config use-context nomeDoCluster
```

## App Para Aplicar os Conceitos

Configuração:
``` Dockerfile
FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY go.mod ./
COPY . .
RUN go build -o server cmd/server/server.go
EXPOSE 8080
CMD ["./server"]
```

Subir o container:
``` bash
docker-compose up -d --build
```

Acessar o container:
``` bash
docker-compose exec goapp bash
```
