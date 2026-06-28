# Tarefa 3 - Provisionando Múltiplas Instâncias EC2 em Sub-redes Diferentes com Terraform

## Objetivo

Nesta tarefa foi desenvolvido um projeto Terraform para provisionar **duas instâncias EC2** utilizando a **VPC padrão da AWS**, porém distribuídas em **sub-redes (Subnets) diferentes**.

O objetivo é compreender como o Terraform trabalha com múltiplos recursos e como a infraestrutura da AWS é organizada em VPCs e Subnets.

---

# Conceitos

## O que é uma VPC?

Uma **Virtual Private Cloud (VPC)** é uma rede virtual isolada dentro da AWS.

Ela funciona como uma rede privada onde são criados os recursos da infraestrutura, como:

* Instâncias EC2
* Bancos de dados
* Load Balancers
* Subnets
* Gateways

Sempre que uma conta AWS é criada, a AWS disponibiliza automaticamente uma **VPC padrão (Default VPC)** em cada região.

---

## O que são Subnets?

Dentro de uma VPC existem as **Subnets**, que são subdivisões da rede.

Cada Subnet pertence a uma **Availability Zone (AZ)** diferente ou à mesma zona, dependendo da arquitetura.

Neste laboratório foram utilizadas duas Subnets distintas para distribuir as duas instâncias EC2.

### Vantagem

Distribuir recursos em Subnets diferentes melhora a organização da infraestrutura e permite arquiteturas mais resilientes e de alta disponibilidade.

---

# Estrutura do Projeto

Neste laboratório foram utilizados os nomes padrão dos arquivos do Terraform.

```text
tarefa3/
│
├── main.tf
├── variables.tf
├── terraform.tfvars
└── README.md
```

Utilizar essa estrutura facilita a execução dos comandos, pois o Terraform reconhece automaticamente esses arquivos.

---

# Acessando o Container Docker

Caso o container esteja parado, primeiro verifique seu status:

```bash
docker ps -a
```

Inicie o container:

```bash
docker start lab2
```

Confirme que ele está em execução:

```bash
docker ps
```

Acesse o terminal do container:

```bash
docker exec -it lab2 /bin/bash
```

---

# Criando a Estrutura do Projeto

Dentro do container:

```bash
cd lab2

mkdir tarefa3

cd tarefa3
```

---

# Criando os Arquivos

## main.tf

```bash
vi main.tf
```

Entrar no modo de inserção:

```text
i
```

Após escrever o código:

```text
Esc
:wq
```

---

## variables.tf

```bash
vi variables.tf
```

Modo de inserção:

```text
i
```

Salvar:

```text
Esc
:wq
```

---

## terraform.tfvars

```bash
vi terraform.tfvars
```

Modo de inserção:

```text
i
```

Salvar:

```text
Esc
:wq
```

---

# Organização dos Arquivos Terraform

Embora seja possível escrever toda a configuração dentro de um único arquivo `main.tf`, essa não é a prática recomendada.

Neste laboratório foi utilizada uma separação de responsabilidades:

| Arquivo            | Responsabilidade                                 |
| ------------------ | ------------------------------------------------ |
| `main.tf`          | Recursos que serão criados                       |
| `variables.tf`     | Declaração das variáveis utilizadas pelo projeto |
| `terraform.tfvars` | Valores atribuídos às variáveis                  |

Essa organização torna o projeto mais legível, facilita a manutenção e segue um padrão amplamente utilizado em ambientes profissionais.

---

# Arquivo variables.tf

Neste arquivo são declaradas todas as variáveis utilizadas pelo projeto.

Exemplo:

* Região da AWS
* Tipo da instância
* AMI
* Lista de Subnets
* Lista de VPCs

Também é possível definir valores padrão (`default`) para algumas variáveis, reduzindo a necessidade de informá-las em todos os ambientes.

---

# VPC Padrão

Neste laboratório não foi informado explicitamente qual VPC deveria ser utilizada.

Quando isso acontece, a AWS utiliza automaticamente a **Default VPC**, desde que ela exista na região selecionada.

Embora isso facilite laboratórios e testes, em ambientes de produção é recomendado informar explicitamente a VPC para garantir que os recursos sejam criados na rede correta.

---

# Inicializando o Terraform

Inicialize o diretório:

```bash
terraform init
```

Esse comando realiza:

* download do provider AWS;
* criação da pasta `.terraform`;
* geração do arquivo `.terraform.lock.hcl`;
* preparação do ambiente para execução do Terraform.

---

# Criando a Infraestrutura

Execute:

```bash
terraform apply
```

Confirme a criação:

```text
yes
```

O Terraform criará:

* EC2 Instance 1
* EC2 Instance 2

Cada uma utilizando uma Subnet diferente.

---

# Validação

Após a execução do `terraform apply`, acesse o console da AWS e confirme que:

* as duas instâncias EC2 foram criadas;
* cada instância está associada à Subnet esperada;
* os recursos foram provisionados corretamente.

Essa validação é importante para garantir que o estado real da infraestrutura corresponde ao estado declarado no Terraform.

---

# Removendo a Infraestrutura

Após finalizar os testes:

```bash
terraform destroy
```

Confirme:

```text
yes
```

Todos os recursos criados serão removidos.

---

# Encerrando a Sessão

Para sair do container:

```bash
exit
```

---

# Conceitos Praticados

Durante esta tarefa foram praticados os seguintes conceitos:

* Infrastructure as Code (IaC)
* Terraform Providers
* Variáveis no Terraform
* Arquivo `terraform.tfvars`
* Organização de projetos Terraform
* Provisionamento de múltiplas instâncias EC2
* VPC (Virtual Private Cloud)
* Subnets
* Docker
* AWS EC2
* AWS Networking

---

# Resultado

Ao final desta tarefa foi possível provisionar duas instâncias EC2 utilizando Terraform, distribuindo cada uma em uma Subnet diferente dentro da VPC da AWS.

Além da criação da infraestrutura, o laboratório reforçou a importância da organização dos arquivos Terraform, da utilização de variáveis e da separação entre código e configuração, seguindo boas práticas adotadas em projetos de Infrastructure as Code.
