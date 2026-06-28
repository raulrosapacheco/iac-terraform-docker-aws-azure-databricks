# Tarefa 4 - Utilizando Módulos no Terraform para Provisionamento de Instâncias EC2

## Objetivo

Nesta tarefa foi desenvolvido um projeto Terraform utilizando **módulos locais** para provisionar infraestrutura na AWS.

O principal objetivo deste laboratório é compreender como organizar projetos Terraform de maneira mais profissional, separando a lógica de criação dos recursos em módulos reutilizáveis.

Como exemplo, foi criado um módulo responsável pelo provisionamento de instâncias EC2, permitindo que o código fique mais organizado, reutilizável e de fácil manutenção.

---

# O que são Módulos no Terraform?

Um **módulo** é um conjunto de arquivos Terraform que encapsula uma funcionalidade específica.

Em vez de escrever toda a infraestrutura em um único arquivo `main.tf`, podemos dividir o projeto em pequenos componentes reutilizáveis.

Na prática, um módulo funciona de maneira semelhante a uma função em uma linguagem de programação: ele recebe parâmetros (variáveis), executa uma determinada lógica e pode retornar resultados (outputs).

Essa abordagem reduz a duplicação de código e facilita a padronização da infraestrutura.

---

# Estrutura do Projeto

Ao final da tarefa, a estrutura ficou organizada da seguinte forma:

```text
tarefa4/
│
├── main.tf
├── outputs.tf
├── README.md
│
└── modules/
    └── ec2-instances/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

Essa organização é amplamente utilizada em projetos profissionais de Infrastructure as Code.

---

# Organização dos Arquivos

## main.tf

É o arquivo principal do projeto.

Neste laboratório ele possui apenas a chamada do módulo responsável por criar as instâncias EC2.

Em vez de declarar diretamente os recursos AWS, o arquivo apenas informa ao Terraform:

* qual módulo utilizar;
* onde o módulo está localizado;
* quais valores serão enviados para ele.

Isso torna o código muito mais limpo.

---

## variables.tf

O arquivo `variables.tf` pertence ao módulo.

Seu objetivo é declarar todas as variáveis esperadas pelo módulo.

Entre elas:

* quantidade de instâncias;
* AMI;
* tipo da instância;
* subnet.

A declaração das variáveis torna o módulo reutilizável em diferentes projetos.

---

## outputs.tf

O módulo retorna informações importantes utilizando **Outputs**.

Neste laboratório foi criado um output responsável por retornar os IDs das instâncias EC2 criadas.

Esses valores podem ser utilizados por outros módulos ou simplesmente exibidos no terminal após o provisionamento.

---

# Passo a Passo Executado

## 1. Verificar se o container está em execução

Primeiro foi verificado se o container Docker utilizado nos laboratórios anteriores estava em execução.

```bash
docker ps
```

---

## 2. Acessar o container

Após confirmar que o container estava ativo, foi aberto um terminal dentro dele.

```bash
docker exec -it lab2 /bin/bash
```

---

## 3. Acessar a pasta do laboratório

```bash
cd lab2
```

---

## 4. Criar a pasta da tarefa

Foi criada uma nova pasta para armazenar os arquivos deste laboratório.

```bash
mkdir tarefa4

cd tarefa4
```

---

## 5. Criar os arquivos principais

Foi criado o arquivo principal do projeto.

```bash
vi main.tf
```

No editor Vim:

```text
i
```

Entrar no modo de inserção.

Após escrever o código:

```text
Esc
:wq
```

Salvar e sair.

Em seguida foi criado o arquivo responsável pelos outputs.

```bash
vi outputs.tf
```

Da mesma forma:

```text
i
Esc
:wq
```

Para verificar os arquivos criados:

```bash
ls
```

---

## 6. Criar a estrutura do módulo

Foi criada a pasta que armazenará os módulos Terraform.

```bash
mkdir modules

cd modules

mkdir ec2-instances

cd ec2-instances
```

Ao final, a estrutura ficou semelhante a:

```text
modules/
└── ec2-instances/
```

---

## 7. Criar os arquivos do módulo

Primeiramente foi criado o arquivo responsável pelas variáveis.

```bash
vi variables.tf
```

Depois o arquivo principal do módulo.

```bash
vi main.tf
```

E por último o arquivo responsável pelos outputs.

```bash
vi outputs.tf
```

Em todos os casos foi utilizado o fluxo padrão do Vim:

```text
i
Esc
:wq
```

---

## 8. Validar os arquivos criados

Após finalizar a escrita dos arquivos, foi realizada uma conferência utilizando o comando `cat`.

Visualizar o arquivo de outputs:

```bash
cat outputs.tf
```

Visualizar o arquivo principal:

```bash
cat main.tf
```

Visualizar o arquivo de variáveis:

```bash
cat variables.tf
```

Essa etapa é importante para verificar rapidamente se o conteúdo foi salvo corretamente.

---

## 9. Retornar para a pasta principal

Após concluir a criação do módulo, foi necessário retornar para a pasta principal do projeto.

```bash
cd /lab2/tarefa4
```

---

## 10. Inicializar o Terraform

Com toda a estrutura criada, foi executado:

```bash
terraform init
```

Esse comando realiza diversas tarefas importantes:

* identifica os arquivos Terraform;
* identifica o módulo local;
* instala o Provider AWS;
* cria a pasta `.terraform`;
* gera o arquivo `.terraform.lock.hcl`;
* prepara o ambiente para execução dos próximos comandos.

---

## 11. Provisionar a infraestrutura

Após a inicialização, foi executado:

```bash
terraform apply
```

O Terraform apresenta um plano contendo todos os recursos que serão criados.

Para confirmar a criação da infraestrutura:

```text
yes
```

Neste momento o Terraform cria as instâncias EC2 definidas pelo módulo.

---

## 12. Visualizar os Outputs

Após o provisionamento, foi possível visualizar todos os outputs do projeto.

```bash
terraform output
```

Caso existam diversos outputs definidos, também é possível consultar apenas um deles.

Neste laboratório foi utilizado:

```bash
terraform output instance_ids
```

Como resultado, o Terraform retorna os IDs das instâncias EC2 criadas.

---

## 13. Validar na AWS

Após a conclusão do `terraform apply`, é recomendável acessar o console da AWS para verificar:

* se as instâncias EC2 foram criadas corretamente;
* se estão utilizando a AMI correta;
* se foram criadas na subnet esperada;
* se estão no estado **Running**.

Essa validação garante que a infraestrutura declarada no Terraform corresponde à infraestrutura criada na AWS.

---

## 14. Remover a infraestrutura

Após finalizar os testes, toda a infraestrutura foi removida utilizando:

```bash
terraform destroy
```

Confirme a operação digitando:

```text
yes
```

Esse comando remove todos os recursos gerenciados pelo Terraform, evitando custos desnecessários na AWS.

---

# Comandos Executados

```bash
docker ps

docker exec -it lab2 /bin/bash

cd lab2

mkdir tarefa4

cd tarefa4

vi main.tf

vi outputs.tf

ls

mkdir modules

cd modules

mkdir ec2-instances

cd ec2-instances

vi variables.tf

vi main.tf

vi outputs.tf

cat outputs.tf

cat main.tf

cat variables.tf

cd /lab2/tarefa4

terraform init

terraform apply

terraform output

terraform output instance_ids

terraform destroy
```

---

# Conceitos Praticados

Durante esta tarefa foram praticados os seguintes conceitos:

* Organização de projetos Terraform;
* Criação de módulos locais;
* Reutilização de código;
* Declaração de variáveis em módulos;
* Utilização de Outputs;
* Comunicação entre projeto principal e módulos;
* Provisionamento de infraestrutura utilizando módulos;
* AWS EC2;
* Docker;
* Infrastructure as Code (IaC).

---

# Boas Práticas

A utilização de módulos é considerada uma das principais boas práticas no Terraform.

Em projetos corporativos é comum existir um repositório contendo módulos reutilizáveis para recursos como:

* EC2;
* VPC;
* Security Groups;
* RDS;
* S3;
* IAM.

Dessa forma, diferentes projetos podem reutilizar os mesmos módulos, alterando apenas os valores das variáveis, sem necessidade de duplicar código.

---

# Resultado

Ao final desta tarefa foi possível criar uma estrutura Terraform modularizada, separando a lógica de criação das instâncias EC2 em um módulo reutilizável.

Além do provisionamento da infraestrutura, também foi demonstrado como expor informações utilizando **Outputs**, permitindo consultar facilmente os IDs das instâncias criadas.

Esse laboratório representa uma evolução importante na organização de projetos Terraform e aproxima a estrutura utilizada das práticas adotadas em ambientes profissionais de Infrastructure as Code.


# Autor

**Raul Rosa**

Data Engineer | Analytics Engineer | Business Intelligence
