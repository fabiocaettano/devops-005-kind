# Configurar Ambiente

## $${\color{Red} Gerar \space Chave \space SSH \space na \space Máquina \space Local}$$

1. Gerar a chave
``` bash
$ ssh-keygen -t rsa -b 2048
```

2. Informar o nome da chave:
``` bash
$ Enter file in which to save the key: /home/user/.ssh/devops
```

3. Informe uma palava secreta:
``` bash
$ Enter passphrase:
$ Enter passphase again:
```

4. Consultar:
``` bash
$ ls -la ~/.ssh
```

## $${\color{Red} Cloud \space Provider \space - \space Digital \space Ocean}$$

### $${\color{blue} Configurar \space SSH}$$

1. No site da Digital Ocean acessar *Settings >> Aba Security >> Botão Add Key*.

2. Na máquina local copiar o conteúdo da chave publica:

``` bash
cat ~/.ssh/devops.pub
```

3. Voltar no site e colar a Public Key.

4. Informar o nome Public Key, o mesmo da máquia local.

5. Botão *Add SSH Key*.


### Gerar TOKEN

1. No site da Digital Ocean acessar *API >> Aba Tokens >> Botão Generate New Token*.

2. Informe um nome para o Token e defina a expiration.

3. Copie o Token.

4. Guardar num local seguro e não publicar em nenhum local, é um dado sensivel.


## $${\color{Red} Provisionar \space Máquina \space Virtual \space com \space TerraForm}$$

### Provisionar

1. A configuração do Terraform irá provisionar uma máquina com a seguinte configuração:
- Sistema Operacional Ubuntu 20.4;
- Processador com 2 vcpu;
- 4 GB de memória.

2. O token gerado no site da Digital Ocean deve ser inserido no arquivo *terraform >> terraform.tfvars":
``` tfvars
token = ""
pvt_key = "/home/fabio/.ssh/devops"
name_key = "devops"
user = "root"
image = "ubuntu-20-04-x64"
region = "nyc1"
size = "s-2vcpu-4gb"
```

3. Provisionar máquina com terraform:
``` bash
cd terraform/droplet
terraform init
terraform plan
terraform apply -auto-approve
```
 
4. Consultar o IP da máquina provisionada:
``` bash
terraform output
```

5. Acessar máquina virtual:
``` bash
ssh agent bash
ssh add ~/.ssh/devops
ssh root@IpDaVm 
```

6. Após usar o recurso é necessário destrui-lo para evitar custos, o cloud-provider é cobrado.
``` bash## $${\color{Red} Provisionar \space Máquina \space Virtual \space com \space TerraForm}$$
terraform destroy -auto-approve
```

## $${\color{Red} Configurar \space Máquina \space Virtual \space com \space Ansible}$$

### Configurar 

1. O arquivo *ansible >> inventory.ini* deve receber o IP da VM, gerado pelo terraform.

``` ini
[droplet01]
informar o ip da vm gerado pel terraform
```

2. No arquivo *ansible >> inventory.ini* preecher as variareis com as credenciais do git.

``` ini
[droplet01:vars]
git_email="email credencais git hub"
git_name="username github"
git_folder="/root/nomeDoRepositorioGit"
```

3. Ativar SSH Agent:
``` bash
cd ansible
ssh agent bash
ssh add  ~/.ssh/devops
```

4. Acessar a pasta com os manifestos:

``` bash
cd ansible
```

5. Executar PlaybooK Individualmente:

- Docker:
``` bash
ansible-playbook -i inventory.ini playbook/01-docker.yaml
```
- Kubectl:
``` bash
ansible-playbook -i inventory.ini playbook/02-kubectl.yaml
```
- Kind:
``` bash
ansible-playbook -i inventory.ini playbook/03-kind.yaml
```
- K3D:
``` bash
ansible-playbook -i inventory.ini playbook/04-K3D.yaml
```

- Transferir chave devops da máquina local para remota:
``` bash
ansible-playbook -i inventory.ini playbook/05-ssh.yaml
```

- Configurar as credenciais do Git:
``` bash
ansible-playbook -i inventory.ini playbook/06-git.config.yaml
```


### Acessar VM

## Cluster
### Provisionar Cluster Kubernetes com TerraForm
### Arquivo config
### Mudar Contexto

Consultar nome dos clusters:

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

