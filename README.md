# devops-005-kubernetes

<b>Sumário</b>

- [Kubernetes](#kubernetes)
- [Provisionar Máquina Virtual (Droplet)](#provisionar-máquina-virtual-droplet)
- [Configurar Ambiente](#configurar-ambiente)    
- [Criar e Deletar Cluster](#criar-e-deletar-cluster)
    - [Kind](#kind)
- [Criar Nodes](#criar-nodes)
    - [Kind](#kind-1)
- [Chavear Clusters](#chavear-clusters)
- [App Para Aplicar os Conceitos](#app-para-aplicar-os-conceitos)
- [Objetos Kubernetes](#objetos-kubernetes)

## Kubernetes 

1. Definição no site kubernetes.io:

<i>"Kubernetes (K8s) é um produto Open Source utilizado para automatizar a implantação, o dimensionamento e o gerenciamento de aplicativos em contêiner."</i>


## Provisionar Máquina virtual (Droplet)

1. Confugaração do Droplet:

2. Provisionar:
```bash
terraform apply -auto-approve
```

3. Visualizar o IP:
``` bash
terraform output
```


4. Destruir máquina virtual:
``` bash
terraform destroy -auto-approve
```



## Configurar Ambiente com Ansible

1. Configurar o arquivo de inventário (inventory.ini):
``` ini
[droplet01]
ipDaMaquinaVirtual
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

5. Enviar chave SSH da máquina local para o Droplet.

``` bash
scp /home/user/.ssh/nomeDaChave root@ipDaMaquinaVirtual:/root/.ssh/nomeDaChave
scp /home/user/.ssh/nomeDaChave.pub root@ipDaMaquinaVirtual:/root/.ssh/nomeDaChave.pub
```

6. Acessar máquina virtual:
``` bash
#ativar o agent ssh
ssh-agent bash
ssh-add ~/.ssh/chaveSSH
#executar o mesmo
ssh root@ipDaMáquinaVirual
```

7. Clonar projeto na máquina virtual:
``` bash
git clone
```

8. Configurar usuário git na máquina virtual:
``` bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

## Criar e Deletar Cluster

### Kind

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

### Kind

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

App desenvolvido em GO.

Gerenciar os pacotes:
``` bash
go mod init github.com/fabiocaettano/servergo
```

Configuração Dockerfile:
``` Dockerfile
FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY . .
CMD ["tail","-f","/dev/null"]
```

Subir container:
``` bash
docker-compose up -d --build
```

Acessar o container:
``` bash
docker-compose exec goapp bash
```

Gerar build dentro do container, será criado um arquivo server no diretório do projeto:
``` bash
GOOS=linux GOARCH=amd64 go build -o server ./cmd/server/
#sair do container
exit
```

Destruir o container:
``` bash
docker-compose down
```
Ajustar Dockerlife:
``` Dockerfile
FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY . .
CMD ["./server"]
```

Subir o container:
``` bash
docker-compose up -d --build
```

Testar o Browser:
``` 
http://ipDaMaquinaVirtual:8080
```

Destruir o container:
``` bash
docker-compose down
```

Ajustar Dockerlife, para multi-stage build para diminuir o tamanho da imagem
``` Dockerfile
FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY . .

FROM alpine:3.16 as binary
COPY --from=base /app .
EXPOSE 8080
CMD ["./server"]
```

Autenticar no Docker Hub, será solicitado uma senha.
Gerar um token no site do Docker Hub:

``` bash
docker login
```

Criar a imagem:
``` bash
docker build -t fabiocaettano74/servergo:v01 .
```

Subir a image para o DockerHub:
``` bash
docker push fabiocaettano74/servergo:v01
```

## Objetos Kubernetes

### Pod

