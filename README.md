# devops-005-kubernetes

<h2>Laboratório para aprendizado da tecnologia Kubernetes.</h2>

<b>Sumário</b>

- [O que é Kubernetes ?](#kubernetes)
- [Provisionar Máquina Virtual com TerraForm](#provisionar-máquina-virtual-com-terraform)
- [Configurar Ambiente com Ansible](#configurar-ambiente-com-ansible)    
- [Chave SSH](#chave-ssh)
- [Acessar VM](#acessar-vm)
- [Clonar Projeto](#clonar-projeto)
- [Ferramentas Para Executar o k8s Localmente](#ferramentas-para-executar-o-k8s-localmente)
    - [Kind](#kind)
        - [Criar e Destruir Cluster](#criar-e-destruir-cluster)
        - [Criar Nodes](#criar-nodes)
    - [k3d]()    
- [Chavear Clusters](#chavear-clusters)
- [App Para Aplicar os Conceitos](#app-para-aplicar-os-conceitos)
- [Objetos Kubernetes](#objetos-kubernetes)
    - [Pod](#pod)
    - [Replicaset](#replicaset)
    - [Deployment](#deployment)

## Kubernetes 

1. Definição no site kubernetes.io:

<i>"Kubernetes (K8s) é um produto Open Source utilizado para automatizar a implantação, o dimensionamento e o gerenciamento de aplicativos em contêiner."</i>


## Provisionar Máquina Virtual com TerraForm

1. Confugaração da VM:

2. Provisionar:
```bash
terraform apply -auto-approve
```

3. Visualizar o IP:
``` bash
terraform output
```

4. Destruir a VM:
``` bash
terraform destroy -auto-approve
```


## Configurar Ambiente com Ansible

1. Configurar o arquivo de inventário (inventory.ini):
``` ini
[droplet01]
ipDaVM
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

## Chave SSH

1. Enviar chave SSH da máquina local para a VM:
``` bash
#ativar o agent ssh
ssh-agent bash
ssh-add ~/.ssh/chaveSSH
#executar o mesmo
scp /home/user/.ssh/nomeDaChave root@ipDaMaquinaVirtual:/root/.ssh/nomeDaChave
scp /home/user/.ssh/nomeDaChave.pub root@ipDaMaquinaVirtual:/root/.ssh/nomeDaChave.pub
```

## Acessar VM

1. Executar:
``` bash
#ativar o agent ssh
ssh-agent bash
ssh-add ~/.ssh/chaveSSH
#executar o mesmo
ssh root@ipDaMáquinaVirual
```

## Clonar Projeto
1. Clonar projeto na máquina virtual:
``` bash
git clone
```

2. Configurar usuário git na máquina virtual:
``` bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

## Ferramentas Para Executar o k8s Localmente

### Kind

#### Criar e Destruir Cluster

1. Criar um cluster básico:
``` bash
kind create cluster
```

2. Ativar o cluster:
``` bash
kubectl cluster-info --context kind-kind
```

3. O kind criar containers :
``` bash
docker ps
```

4. Para checar os nodes criados pelo Kind:
```  bash
kubectl get nodes
```

5. Consultar o clusters:
``` bash
kind get clusters
```

6. Deletar o cluster:
``` bash
kind delete clusters kind
```

#### Criar Nodes

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
kind create cluster --config=k8s/001-create-cluster.yaml --name=cluster-laboratorio
```

Ativar:
``` bash
kubectl cluster-info --context kind-fullcycle
```

Checar os nodes:
``` bash
kubectl get nodes
```

### K3d

## Chavear Clusters

Consultar clusters:
``` bash
kubectl config get-clusters
```
Consultar Nodes:
``` bash
kubectl get nodes
```
Para chavear: 
``` bash
kubectl config use-context nomeDoCluster
```

## App Para Aplicar os Conceitos

### Ambiente Desenvolvimento

1. Controle dos pacotes:
```
go mod init github.com/fabiocaettano/servergo
```

2. Criar Dockerfile:
``` Dockerfile
FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY . .
CMD ["tail","-f","/dev/null"]
```

3. Manifesto Docker-Compose:
``` yaml
version: '3.3'
services: 
  goapp:
    build:
      dockerfile: Dockerfile      
      context: .
    ports:
      - 8080:8080
    volumes:
      - .:/app
```

4. Subir Container:
``` bash
docker-compose up -d --build
```
5. Acessar Container:
```
docker-compose exec goapp bash
```

6. Executar o dentro do container Build:
``` bash
CGO_ENABLED=0 GOOS=linux go build -o server ./cmd/server
```

### Multi-Stage

1. Objetivo:

- Diminuir o tamanho da imagem de 1GB para 7MB;
- Enviar imagem para o Docker Hub.

2. Criar DockerFile:
``` Dockerfile
FROM golang:1.19 as base
RUN apt update
WORKDIR /app
RUN go mod init github.com/fabiocaettano/servergo
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o server ./cmd/server

FROM scratch as binary
WORKDIR /app
COPY --from=base /app/server .
EXPOSE 8080
CMD ["./server"]
```

3. Desabilitar o volume no Docker-Compose.

Docker-Compose:
``` yaml
version: '3.3'
services: 
  goapp:
    build:
      dockerfile: Dockerfile      
      context: .
    ports:
      - 8080:8080
```


4. Enviar imagem para o DockerHub

Autenticar no Docker Hub, será solicitado uma senha.

Gerar um token no site do Docker Hub:

``` bash
docker login
```

5. Criar a imagem:
``` bash
docker build -t fabiocaettano74/servergo:v01 .
```
6. Testar a imagem localmente:
``` bash
docker run --rm -p 8000:8080 fabiocaettano74/servergo
```

7. Subir a image para o DockerHub:
``` bash
docker push fabiocaettano74/servergo:v01
```

## Objetos Kubernetes

### Pod

1. Conceitos:
- É o menor objeto do Kubernetes
- Responsável por executar o Container
- O Pod é efemero (nasce e morre)
- Não é resiliente
- O Pod sozinho não é muito útil

2. Criar um Pod:
``` bash
kubectl apply -f k8s/002-create-pod.yaml
```

3. Consultar:
``` bash
kubectl get pods
kubectl get po
```

4. Liberar acesso ao Pod:
``` bash
kubectl port-forward pod/server 8080:8080
```

Mas esse acesso é somente interno.
Abrir outro terminal:
``` bash
curl http://localhost:8080
```
Resultado Esperado:
``` html
<h1>Hello Kubernetes com Kind!!!</h1>
```

5. Deletar um Pod:
``` bash
kubectl delete pod server
```

6. O próximo objeto *Replica Set* resolve a questão de Criar e Recriar os Pods.


### ReplicaSet

1. Conceitos:

- Gerencia os Pods;
- Escalonamento dos Pods;
- Cria e Recria os Pods.

2. Criar o Replicaset:

Executar:
```
kubectl apply -f k8s/003-create-replicaset.yaml
```

3. Consultar Pods:

Executar:
``` bash
kubectl get pods
```
Resultado:
```bash
NAME           READY   STATUS    RESTARTS   AGE
server-fsv6k   1/1     Running   0          8s
server-v6798   1/1     Running   0          8s
```

4. Consultar Replicaset

Executar:
``` bash
kubectl get replicaset
```

Resultado:
``` bash
NAME     DESIRED   CURRENT   READY   AGE
server   2         2         2       3m19s
```

5. Ao deletar um Pod, agora ele será recriado de forma automática por conta do ReplicaSet.

O papel do Replicaset é manter o número de pods desejados (DESIRED).

Deletar um pod:
``` bash
kubectl delete pod server-fsv6k
```

Ao consultar o POD observar a coluna AGE:
``` bash
NAME           READY   STATUS    RESTARTS   AGE
server-5kq7d   1/1     Running   0          11s
server-v6798   1/1     Running   0          7m27s
```

6. O kubernetes disponibliza um comando para checar a descrição de um POD.

Visualizar a descrição do POD:
``` bash
kubectl describe pod 5kq7d
```

Os pods server-5kq7d e server-v6798 tem como base a imagem fabiocaettano74@servergo:v03.

A imagem do manifesto será alterado para fabiocaettano74@servergo:v04.

E o número de réplicas alterado para 4.

Esta nova configuração será aplicará a nova imagem somente os novos Pods.


Excluir os Pods para o Replicaset atuar e subir 02 novos Pods atualizados.:

``` bash
kubectl delete pod server-5kq7d server-v6798
```

7. Deletar o Replicaset

``` bash
kubectl delete replicaset server
```

8. Com relação atualização das imagens não é muito produtivo com o *ReplicaSet*.
O próximo objeto *Deployment" resolve esa questão.


### Deployment 

1. Conceitos

- O Deployment gerencia o Replicaset
- Quando o manifesto for atualizado, os Pods serão destruibos, e recriados com a nova configuração.
- Os Pods são destruidos de forma progressiva para não gerar um *Downtime*


2. Alterações no manifesto 004-create-deployment.yaml:
- Mudança na imagem para versão 05.
- Alteração na quantidade de réplicas para 10.

3. Aplicar manifesto:

Executar:
``` bash
kbuectl apply -f k8es/004-create-deployment.yaml
```

Resultado:

``` bash
NAME                     READY   STATUS    RESTARTS   AGE
server-b5984575f-556b7   1/1     Running   0          4m36s
server-b5984575f-5wrz5   1/1     Running   0          4m36s
server-b5984575f-fbwfj   1/1     Running   0          4m36s
server-b5984575f-fdt6b   1/1     Running   0          4m36s
server-b5984575f-kx24q   1/1     Running   0          4m36s
server-b5984575f-pqnhw   1/1     Running   0          4m36s
server-b5984575f-qbsns   1/1     Running   0          4m36s
server-b5984575f-rhnwh   1/1     Running   0          4m36s
server-b5984575f-wvhgn   1/1     Running   0          4m36s
server-b5984575f-zmpvc   1/1     Running   0          4m36s
```

Consultar Deployment:

``` bash
kubectl get deployment
```

Resultado:

``` bash
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
server   10/10   10           10          5m34s
```

## Rollout e Revisões

1. Visualizar o histório.

Executar:
``` bash
kubectl rollout history deployment server
```
Resultado:
``` bash
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
3         <none>
4         <none>
```

2. A coluna CHANGE-CAUSE possibilita deixar uma anotação, facilitando identificar a versão:

Anotação será realizada na última REVISION, ou seja, na versão que está em execução.

Exemplo:

``` bash
 kubectl annotate deployment/server kubernetes.io/change-cause="update image version v04 to v05"
```

Resultado:
``` bash
REVISION  CHANGE-CAUSE
8         <none>
9         <none>
10        update image version v07 to v08
11        update image version v04 to v05
```


3. Retornar versão anterior

Executar:
``` bash
kubectl rollout undo deployment server
```

4. Retornar para uma versão especifica:
``` bash
kubectl rollout undo deployment server --to-revision=6
```
