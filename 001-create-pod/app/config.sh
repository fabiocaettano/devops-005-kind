#!/bin/bash

# excluir binário
echo "1/11 Excluir Binário"
rm -rf server

# gerar binário
echo "2/11 Gerar Binário"
CGO_ENABLED=0 GOOS=linux go build -o server ./cmd/web

# destruir container
echo "3/11" Destruir container
docker-compose down

# subir container
echo "4/11" Subir Container
docker-compose up -d --build

# informar versao
echo "5/11 Versionar Imagem Docker Hub"
echo -n "Versão da imagem: "
read -r version
export VERSAO=$version 

# construir imagem
echo "6/11 construir imagem"
docker build -t fabiocaettano74/servergo:${VERSAO} .

# tag
echo "7/11 tag imagem"
docker tag fabiocaettano74/servergo:${VERSAO} fabiocaettano74/servergo:latest

# subir imagem
echo "8/11 subir imagem para docker hub"
docker push fabiocaettano74/servergo:${VERSAO}
docker push fabiocaettano74/servergo:latest

# deletar pod
echo "9/11 deletar pod"
kubectl delete pod server

# subir cluster
echo "10/11 criar pod"
cd /root/devops-005-kubernetes/ && kubectl apply -f k8s/create-pod.yaml

# consultar pods
echo "11/11 consultar pods"
kubectl get pods