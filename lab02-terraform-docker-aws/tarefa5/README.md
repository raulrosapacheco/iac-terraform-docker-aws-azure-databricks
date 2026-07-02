# Terraform Lab 05 - Módulos (EC2 e S3)

## Objetivo

Este laboratório tem como objetivo praticar a criação e reutilização de módulos no Terraform, aplicando boas práticas de organização da infraestrutura como código (IaC).

Neste projeto são utilizados dois módulos independentes:

- EC2 Instances
- S3 Bucket

O módulo principal é responsável apenas por consumir esses módulos e realizar a composição da infraestrutura.

---

## Estrutura do Projeto

```
tarefa5/
│
├── main.tf
├── outputs.tf
│
└── modules/
    ├── ec2-instances/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── s3-bucket/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## Pré-requisitos

- Docker Desktop em execução
- Container `lab2`
- Terraform instalado no container
- Credenciais AWS configuradas

---

## Acessando o ambiente

Verifique os containers existentes:

```bash
docker ps -a
```

Caso o container esteja parado:

```bash
docker start lab2
```

Acesse o container:

Linux / PowerShell

```bash
docker exec -it lab2 /bin/bash
```

Git Bash

```bash
docker exec -it lab2 //bin/bash
```

---

## Navegação

Verificar arquivos:

```bash
ls -la
```

Entrar no diretório do laboratório:

```bash
cd lab2
```

Criar a pasta do projeto:

```bash
mkdir tarefa5
cd tarefa5
```

---

## Estrutura dos módulos

Criar diretórios:

```bash
mkdir modules
cd modules

mkdir ec2-instances
mkdir s3-bucket
```

### Módulo EC2

```bash
cd ec2-instances
```

Criar arquivos:

```bash
vi main.tf
vi variables.tf
vi outputs.tf
```

---

### Módulo S3

```bash
cd ../s3-bucket
```

Criar arquivos:

```bash
vi main.tf
vi variables.tf
vi outputs.tf
```

---

## Arquivos do projeto principal

Retorne para a raiz do projeto:

```bash
cd ../../
```

Crie os arquivos:

```bash
vi main.tf
vi outputs.tf
```

---

## Inicialização do Terraform

Inicializar o projeto:

```bash
terraform init
```

Validar a configuração:

```bash
terraform validate
```

Visualizar o plano de execução:

```bash
terraform plan
```

Aplicar a infraestrutura:

```bash
terraform apply
```

---

## Consultando Outputs

Todos os outputs:

```bash
terraform output
```

IDs das instâncias EC2:

```bash
terraform output instance_ids
```

ID do Bucket S3:

```bash
terraform output bucket_id
```

---

## Removendo a infraestrutura

```bash
terraform destroy
```

---

## Conceitos praticados

- Organização de projetos Terraform
- Criação de módulos reutilizáveis
- Separação entre infraestrutura principal e módulos
- Definição de variáveis
- Utilização de outputs
- Provisionamento de instâncias EC2
- Provisionamento de Bucket S3
- Reutilização de código com módulos
