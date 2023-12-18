# $${\color{Black} Executar \space Projeto }$$

1. Na máquina local provisionar 01 máquina virtual com Terraform no cloud provider da Digital Ocean:
``` bash
$ cd terraform/droplet
$ terraform apply "infra.out"
```

2. Anotar o IP informado no final da provisionamento feito pelo Terraform.

3. Informar o IP no arquivo **ansible >> inventory.ini**

4. Ainda na máquina local configurar a máquina remota com Ansible:
``` bash
$ cd ansible
$ ssh-agent bash
$ ssh-add ~/.ssh/devops
$ ansible-playbook -i inventory.ini playbook/configurar-ambiente.yaml
```

5. Acessar a máquina remota:
``` bash
$ ssh-agent bash
$ ssh-add ~/.ssh/devops
$ ssh root@IpDaMaquinaVirtual
```

6. Na máquina remota, ativar o agente ssh e clonar o projeto.
``` bash
$ ssh-agent bash
$ ssh-add ~/.ssh/devops
$ git clone git@github.com:fabiocaettano/devops-005-kubernetes.git
```

