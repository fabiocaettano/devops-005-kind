# Ambiente para o Laboratório


## <h2>1.0 Executar Projeto</h2>



## <h2>2.0 Configurar Ambiente</h2>

### <h3>2.1 Gerar Chave SSH na Máquina Local</h3>

1. Gerar a chave:
``` bash
$ ssh-keygen -t rsa -b 2048
```

2. Informar o nome da chave:
``` bash
$ Enter file in which to save the key: /home/user/.ssh/devops
```

3. Informe uma palavra secreta:
``` bash
$ Enter passphrase: palavraSecreta
$ Enter passphase again: palavraSecreta
```

4. Consultar:
``` bash
$ ls -la ~/.ssh
```

### <h3>2.2 Configurar Git</h3>

1. No site [GitHub](https://github.com)  ir na opção **Settings >>  SSH and GPG Keys >> Botão New SSH Key**.

2. No **campo Title** informe o nome da **Chave Pública SSH**.

3. No **campo Key Type** manter o valor Authentication Key.

4. Agora na máquina local copiar o conteúdo da chave publica SSH:

``` bash
$ cat ~/.ssh/devops.pub
```

5. Voltar no site e colar o conteúdo da chave pública no **campo Key**.

6. Concluir utilizando o botão **Add SSH Key**.

7. Isso permitirá que a máquina remota possa clonar os repostiórios do git.


### <h3>2.3 Cloud Provider - Configurar SSH e Gerar Token</h3>

1. No site da [Digital Ocean](https://cloud.digitalocean.com/) acessar **Settings >> Aba Security >> Botão Add Key**.

2. Na máquina local copiar o conteúdo da chave publica SSH:

``` bash
$ cat ~/.ssh/devops.pub
```

3. Voltar no site e colar o contéudo da chave pública Key.

4. Informar o nome da chave pública Key, o mesmo da máquia local.

5. Botão **Add SSH Key**.

6. Ainda no site acessar **API >> Aba Tokens >> Botão Generate New Token**.

7. Informe um nome para o Token e defina o tempo de expiração, no campo **expiration**.

8. Copiar Token, exibido na tela.

9. Guardar num local seguro e não publicar em nenhum local, é um dado sensivel.


### <h3>2.4 Provisionar Máquina Virtual com TerraForm<h3>

1. A configuração do Terraform irá provisionar uma máquina com a seguinte configuração:
- Sistema Operacional Ubuntu 20.4;
- Processador com 2 vcpu;
- 4 GB de memória;
- 50 GB de HD.

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
$ cd terraform/droplet
$ terraform init
$ terraform plan -out=infra.out
$ terraform apply "infra.out"
```
 
4. Consultar o IP da máquina provisionada:
``` bash
$ terraform output
```

5. Acessar máquina virtual:
``` bash
$ ssh agent bash
$ ssh add ~/.ssh/devops
$ ssh root@IpDaVm 
```

6. Após usar o recurso é necessário destrui-lo para evitar custos, o cloud-provider é cobrado.
``` bash
$ terraform destroy -auto-approve
```

## $${\color{Red} Configurar \space Máquina \space Virtual \space com \space Ansible}$$

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
```

3. Ativar SSH Agent:
``` bash
$ cd ansible
$ ssh agent bash
$ ssh add  ~/.ssh/devops
```

4. Acessar a pasta com os manifestos:

``` bash
$ cd ansible
```

5. Executar PlaybooK:

Instalar Docker, Kubectl, Kind, K3d, transferir chaves SSH e configurar credenciais do GIT.
``` bash
$ ansible-playbook - inventory.ini playbook/configurar-ambiente.yaml
```

Validar instalação acessando a Máquina Virtual (opcional):
``` bash
$ ssh root@IpDaMáquinaVirtual
```

Consultar:
``` bash
$ docker --version
$ kubectl version
$ kind version
$ k3d version
$ ls -la ~/.ssh
$ git config --list
```


## $${\color{Red} Clonar \space Projeto}$$

1. Na máquina local:
``` bash
$ ssh agent bash
$ ssh add ~/.ssh/devops
$ ssh root@IpDaMaquinaVirtual
```

2. Na máquina remota, clonar o projeto:
``` bash
$ ssh agent bash
$ ssh add ~/.ssh/devops
$ git clone git@github.com:fabiocaettano/devops-005-kubernetes.git
```

3. Consultar na máquina remota:
``` bash
cd devops-005-kubernetes
git branch -a
```

3. Clonar Projeto
```
$ git clone https://github.com/fabiocaettano/devops-005-kubernetes.git
```