# Terraform Lab 2 - Provisionamento de Infraestrutura na AWS com Docker

## 📋 Sobre o Projeto

Este projeto demonstra a utilização do **Terraform** para provisionamento de infraestrutura na **AWS**, executando toda a ferramenta dentro de um **container Docker**, sem necessidade de instalar o Terraform diretamente na máquina hospedeira.

O laboratório contempla:

- Criação de uma imagem Docker personalizada;
- Instalação do Terraform e AWS CLI;
- Provisionamento de uma instância EC2 na AWS;
- Geração do plano de execução;
- Aplicação da infraestrutura;
- Destruição dos recursos criados.

---

## 🏗️ Arquitetura

```
Máquina Local
       │
       ▼
 Docker Container
       │
 ├── Terraform
 ├── AWS CLI
 └── Código Terraform
       │
       ▼
       AWS
       │
       ▼
     EC2 Instance
```

---

## 📁 Estrutura do Projeto

```
.
├── Dockerfile
├── README.md
└── tarefa1
    ├── main.tf
```

---

## 🚀 Tecnologias Utilizadas

- Docker
- Terraform 1.12.2
- AWS CLI v2
- Ubuntu
- Amazon EC2
- AWS Provider

---

## 📦 Pré-requisitos

Antes de executar o projeto, é necessário possuir:

- Docker instalado
- Conta AWS
- Access Key e Secret Key da AWS
- Permissão para criação de instâncias EC2

---

## 🔨 Construindo a Imagem Docker

```bash
docker build -t terraform-image:lab2 .
```

---

## ▶️ Executando o Container

```bash
docker run -dit --name lab2 terraform-image:lab2 /bin/bash
```

Acesse o container:

```bash
docker exec -it lab2 /bin/bash
```

---

## 🔐 Configurando a AWS

Configure suas credenciais:

```bash
aws configure
```

Informe:

- AWS Access Key ID
- AWS Secret Access Key
- Região
- Output Format

---

## 📂 Navegando até o Projeto

```bash
cd /lab2/tarefa1
```

---

## ⚙️ Inicializando o Terraform

```bash
terraform init
```

Este comando realiza:

- Download do provider AWS;
- Criação da pasta `.terraform`;
- Geração do arquivo `.terraform.lock.hcl`.

---

## 🔒 Dependency Lock File

Após o `terraform init`, será criado o arquivo:

```
.terraform.lock.hcl
```

Esse arquivo registra:

- versão exata do provider;
- hashes de verificação;
- integridade dos binários.

Seu objetivo é garantir que todos os ambientes utilizem exatamente a mesma versão do provider.

Visualizar:

```bash
ls -la

cat .terraform.lock.hcl
```

---

## 📄 Gerando o Plano

```bash
terraform plan \
-var "instance_type=t3.micro" \
-var "ami=ami-04a8291398335a9ac" \
-out lab2-plan.tfplan
```

O plano permite revisar todas as alterações antes da criação dos recursos.

---

## 🚀 Aplicando a Infraestrutura

Aplicando o plano salvo:

```bash
terraform apply lab2-plan.tfplan
```

Ou diretamente:

```bash
terraform apply \
-var "instance_type=t3.micro" \
-var "ami=ami-04a8291398335a9ac"
```

---

## 🗑️ Removendo a Infraestrutura

```bash
terraform destroy \
-var "instance_type=t3.micro" \
-var "ami=ami-04a8291398335a9ac"
```

---

## 📌 Recursos Criados

O código Terraform cria:

- 1 Instância EC2

Com:

- AMI informada por variável
- Tipo da instância informado por variável
- Região configurável
- Tag:

```
Name = tarefa1-terraform
```

---

## 🐳 Dockerfile

O Dockerfile realiza:

- Instala Ubuntu;
- Instala Terraform;
- Instala AWS CLI;
- Copia os arquivos Terraform para o container;
- Define `/bin/bash` como comando padrão.

---

## 📚 Conceitos Praticados

- Infrastructure as Code (IaC)
- Terraform Providers
- Terraform State
- Dependency Lock File
- Variáveis
- Docker
- AWS CLI
- Amazon EC2
- Provisionamento declarativo

---

## 🔍 Verificando Versões

Terraform

```bash
terraform version
```

AWS CLI

```bash
aws --version
```

---

## 👨‍💻 Autor

**Raul Rosa**

Data Engineer | Analytics Engineer | Business Intelligence