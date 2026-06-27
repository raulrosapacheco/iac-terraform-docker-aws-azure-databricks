# Lab 01 - Terraform com Docker e AWS CLI

Este laboratório tem como objetivo demonstrar a utilização do **Terraform** executando dentro de um **container Docker**, utilizando a **AWS CLI** para autenticação e criação de recursos na AWS.

Durante o laboratório será criada uma instância EC2 utilizando o conceito de **Infrastructure as Code (IaC)**.

---

# Objetivos

- Criar uma imagem Docker contendo Terraform e AWS CLI.
- Executar um container baseado nessa imagem.
- Configurar as credenciais da AWS.
- Criar uma instância EC2 utilizando Terraform.
- Destruir a infraestrutura criada.

---

# Tecnologias utilizadas

- Docker
- Terraform
- AWS CLI
- Amazon EC2
- Infrastructure as Code (IaC)

---

# Estrutura do projeto

```text
.
├── Dockerfile
├── main.tf
├── .gitignore
├── .dockerignore
└── README.md
```

---

# Construindo a imagem Docker

Na raiz do projeto execute:

```bash
docker build -t terraform-image:lab1 .
```

### Explicação

- `docker build` → cria uma imagem Docker.
- `-t terraform-image:lab1` → atribui um nome e uma tag para a imagem.
- `.` → utiliza o diretório atual como contexto do build.

---

# Criando o container

Execute:

```bash
docker run -dit --name lab1 terraform-image:lab1 /bin/bash
```

### Explicação

- `docker run` → cria um novo container.
- `-d` → executa em segundo plano.
- `-i` → mantém a entrada padrão aberta.
- `-t` → cria um terminal interativo.
- `--name lab1` → nome do container.
- `terraform-image:lab1` → imagem utilizada.
- `/bin/bash` → inicia o terminal Bash dentro do container.

---

# Acessando o container

```bash
docker exec -it lab1 /bin/bash
```

---

# Verificando as instalações

Confira se o Terraform e a AWS CLI foram instalados corretamente.

```bash
terraform version
```

```bash
aws --version
```

---

# Configurando a AWS CLI

Execute:

```bash
aws configure
```

Informe:

- AWS Access Key ID
- AWS Secret Access Key
- Default region name
- Default output format (pressione Enter para deixar em branco, se desejar)

> Caso queira alterar alguma configuração, basta executar novamente o comando `aws configure`.

---

# Verificando os buckets S3

Listar todos os buckets:

```bash
aws s3 ls
```

Listar apenas os nomes:

```bash
aws s3 ls | awk '{print $NF}'
```

Caso não exista nenhum bucket, nenhuma informação será exibida.

---

# Estrutura Terraform

O arquivo `main.tf` contém a definição da infraestrutura que será criada.

Ele realiza:

- Configuração do provider AWS.
- Definição da região.
- Criação de uma instância EC2.
- Definição das tags da instância.

---

# Inicializando o Terraform

Antes da primeira execução é necessário inicializar o projeto.

```bash
terraform init
```

Esse comando realiza:

- Download do provider AWS.
- Criação da pasta `.terraform`.
- Preparação do ambiente de trabalho.
- Inicialização do projeto Terraform.

---

# Criando a infraestrutura

Execute:

```bash
terraform apply
```

O Terraform exibirá o plano de execução.

Para confirmar:

```text
yes
```

Após a confirmação, será criada uma instância EC2 na AWS.

---

# Removendo a infraestrutura

Para evitar custos na AWS, remova todos os recursos criados.

```bash
terraform destroy
```

Confirme digitando:

```text
yes
```

---

# Observação importante

Após executar o comando:

```bash
terraform init
```

não é necessário executá-lo novamente sempre que desejar recriar a infraestrutura.

Basta utilizar:

```bash
terraform apply
```

Isso ocorre porque o `terraform init` prepara o ambiente apenas uma vez, realizando o download dos providers e criando a pasta `.terraform`.

Será necessário executar novamente o `terraform init` somente quando:

- o projeto for clonado em outra máquina;
- a pasta `.terraform` for removida;
- houver alteração nos providers;
- forem adicionados novos módulos.

---

# Conceitos abordados

- Docker
- Containers
- AWS CLI
- Terraform
- Provider
- Resource
- Amazon EC2
- Infrastructure as Code (IaC)

---

# Autor

**Raul Rosa**

Projeto desenvolvido para estudos de Docker, Terraform e AWS.