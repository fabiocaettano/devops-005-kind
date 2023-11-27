# devops-005-kind
Kubernetes curso FullCycle

## Configurar Ambiente

Ativar o agent ssh:
``` ssh
ssh-agent bash
ssh-add ~/.ssh/fullcycle
```

Instalar Kubectl:
``` bash
kubectl apply -i hosts/inventory.ini playbook/collections/kubectl.yaml
```
Instalar Docker:
``` bash
kubectl apply -i hosts/inventory.ini playbook/collections/docker.yaml
```
Instalar GO:
``` bash
kubectl apply -i hosts/inventory.ini playbook/collections/go.yaml
```
Instalar Kind:
``` bash
kubectl apply -i hosts/inventory.ini playbook/collections/kind.yaml
```

## Criando e Deletando Cluster no Kind

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

## Criando Nodes

Arquivo kind.yaml para criar um cluster com 1 control pane e 3 worker nodes.
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
kind create cluster --config=kind.yaml --name=fullcycle
```

Ativar:
``` bash
kubectl cluster-info --context kind-fullcycle
```

Checar os nodes:
``` bash
kubectl get nodes
```

## Consultar Clusters

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

## Aplicativo 

``` Dockerfile
FROM golang:1.20
WORKDIR /app
COPY . .
CMD ["tail","-f","/dev/null"]
```

```
docker-compose up -d --build
```

```
docker-compose exec goapp bash
```