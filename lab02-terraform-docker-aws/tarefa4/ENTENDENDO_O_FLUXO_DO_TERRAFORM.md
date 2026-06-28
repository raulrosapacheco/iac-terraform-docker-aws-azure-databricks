# Entendendo o Fluxo de Execução do Terraform

## Introdução

Durante a execução deste laboratório, uma dúvida muito importante surgiu:

> **Como o Terraform interpreta todo esse projeto?**

À primeira vista, parece que o Terraform simplesmente executa os comandos presentes no `main.tf`, mas internamente existe um fluxo muito bem definido.

Entender esse processo ajuda a compreender como funcionam módulos, variáveis, outputs, providers e o próprio mecanismo de provisionamento da infraestrutura.

---

# Estrutura do Projeto

Neste laboratório foi utilizada a seguinte estrutura:

```text
tarefa4/
│
├── main.tf
├── outputs.tf
│
└── modules/
    └── ec2-instances/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

O projeto possui dois níveis:

* Projeto principal
* Módulo local

---

# Visão Geral do Processo

Quando executamos:

```bash
terraform apply
```

O Terraform executa um fluxo semelhante ao abaixo:

```text
Ler o projeto principal

↓

Encontrar módulos

↓

Ler os módulos

↓

Resolver variáveis

↓

Montar todos os recursos

↓

Construir o plano

↓

Enviar para o Provider

↓

Provider chama a API da AWS

↓

AWS cria a infraestrutura

↓

Terraform salva o estado

↓

Exibe os Outputs
```

Vamos entender cada etapa.

---

# Etapa 1 — O Terraform lê todos os arquivos `.tf`

Uma dúvida muito comum é imaginar que o Terraform começa pelo arquivo `main.tf`.

Na realidade isso **não acontece**.

O Terraform lê **todos os arquivos com extensão `.tf`** existentes na pasta atual.

Por exemplo:

```text
main.tf

outputs.tf

network.tf

security.tf
```

Todos eles são carregados para memória.

Internamente é como se fossem unidos em um único grande arquivo.

Ou seja, para o Terraform não existe diferença entre:

```text
main.tf
outputs.tf
```

e

```text
infra.tf
aws.tf
saida.tf
```

Desde que o arquivo possua extensão `.tf`, ele fará parte da configuração.

---

# Etapa 2 — Encontrando um módulo

Durante a leitura do projeto principal, o Terraform encontra o bloco:

```hcl
module "ec2_instances" {

    source = "./modules/ec2-instances"

    instance_count = 2

    ami_id = ...

}
```

Neste momento ele entende que existe outro projeto Terraform dentro da pasta:

```text
modules/ec2-instances
```

Então ele interrompe momentaneamente a leitura do projeto principal para carregar esse módulo.

---

# Etapa 3 — O módulo também é um projeto Terraform

Ao entrar na pasta do módulo, o Terraform faz exatamente o mesmo processo.

Ele procura todos os arquivos `.tf`.

No exemplo:

```text
main.tf

variables.tf

outputs.tf
```

Novamente, esses arquivos são interpretados como uma única configuração.

Isso significa que um módulo nada mais é do que um pequeno projeto Terraform reutilizável.

---

# Etapa 4 — Registrando as variáveis

Durante a leitura do módulo, o Terraform encontra declarações como:

```hcl
variable "instance_type" {}
```

Nesse momento ele apenas registra que existe uma variável chamada:

```text
instance_type
```

Ainda não existe nenhum valor associado.

O Terraform apenas entende que esse valor será fornecido posteriormente.

---

# Etapa 5 — Recebendo os valores enviados pelo projeto principal

Voltando ao projeto principal, o Terraform encontra:

```hcl
module "ec2_instances" {

    instance_type = "t3.micro"

    ami_id = "ami-04a8291398335a9ac"

}
```

Agora acontece a associação das variáveis.

Internamente é como se o Terraform construísse uma tabela:

| Variável       | Valor recebido        |
| -------------- | --------------------- |
| instance_type  | t3.micro              |
| ami_id         | ami-04a8291398335a9ac |
| subnet_id      | subnet-xxxxxxxx       |
| instance_count | 2                     |

A partir desse momento, todas as referências `var.xxx` passam a possuir um valor definido.

---

# Etapa 6 — Construindo os recursos

Agora o Terraform volta ao arquivo:

```text
modules/ec2-instances/main.tf
```

Lá existe algo semelhante a:

```hcl
resource "aws_instance" "instance" {

    ami = var.ami_id

    instance_type = var.instance_type

}
```

Como as variáveis já receberam seus valores, o Terraform faz a substituição.

Na prática ele passa a enxergar algo semelhante a:

```hcl
ami = "ami-04a8291398335a9ac"

instance_type = "t3.micro"
```

Nesse momento toda a configuração da infraestrutura já está completamente definida.

---

# Etapa 7 — Executando o `count`

O recurso possui:

```hcl
count = 2
```

O Terraform interpreta isso como:

> Crie duas cópias deste recurso.

Internamente ele gera:

```text
aws_instance.instance[0]

aws_instance.instance[1]
```

Embora exista apenas um bloco de código, dois recursos independentes serão criados.

---

# Etapa 8 — Construindo o Plano

Agora o Terraform conhece completamente a infraestrutura desejada.

Ele monta uma representação semelhante a:

```text
Projeto

↓

Módulo

↓

Instância EC2

↓

Instância 1

↓

Instância 2
```

Em seguida compara essa infraestrutura com o estado atual registrado no arquivo:

```text
terraform.tfstate
```

Caso as instâncias ainda não existam, o plano será semelhante a:

```text
+ Criar EC2

+ Criar EC2
```

Esse é exatamente o resultado exibido pelo comando:

```bash
terraform plan
```

ou

```bash
terraform apply
```

---

# Etapa 9 — O Provider AWS entra em ação

Até este momento o Terraform ainda não criou absolutamente nada.

Ele apenas organizou todas as informações.

Agora o Provider AWS recebe instruções como:

```text
Criar EC2

AMI:
ami-04a8291398335a9ac

Tipo:
t3.micro

Subnet:
subnet-xxxxxxxx
```

O Provider converte essas informações em chamadas para a API da AWS.

É como se executasse:

```text
CreateInstance()
```

A AWS responde informando o resultado da operação.

Por exemplo:

```text
Instance ID

i-0123456789abcdef
```

O Provider devolve essa informação ao Terraform.

---

# Etapa 10 — Salvando o Estado

Depois que todos os recursos são criados, o Terraform gera ou atualiza o arquivo:

```text
terraform.tfstate
```

Esse arquivo registra tudo o que foi criado.

Na próxima execução, o Terraform compara o estado desejado com o estado salvo para decidir quais ações devem ser executadas.

---

# Etapa 11 — Processando os Outputs

Após finalizar o provisionamento, o Terraform lê os arquivos `outputs.tf`.

No módulo existe um output semelhante a:

```hcl
output "instance_ids" {

    value = aws_instance.instance[*].id

}
```

No projeto principal existe outro output:

```hcl
output "instance_ids" {

    value = module.ec2_instances.instance_ids

}
```

O projeto principal apenas repassa a saída produzida pelo módulo.

Quando executamos:

```bash
terraform output
```

O Terraform imprime essas informações no terminal.

---

# Fluxo Completo

Todo o processo pode ser resumido da seguinte forma:

```text
terraform apply

        │

        ▼

Lê todos os arquivos .tf

        │

        ▼

Carrega os módulos

        │

        ▼

Lê os arquivos do módulo

        │

        ▼

Registra as variáveis

        │

        ▼

Recebe os valores enviados pelo projeto principal

        │

        ▼

Substitui todas as referências var.xxx

        │

        ▼

Constrói os recursos

        │

        ▼

Aplica o count

        │

        ▼

Gera o plano de execução

        │

        ▼

Envia o plano ao Provider AWS

        │

        ▼

Provider realiza chamadas para a API da AWS

        │

        ▼

AWS cria a infraestrutura

        │

        ▼

Terraform atualiza o terraform.tfstate

        │

        ▼

Processa os Outputs

        │

        ▼

Exibe os resultados ao usuário
```

---

# Conclusão

O Terraform não executa simplesmente os arquivos na ordem em que aparecem.

Primeiro ele interpreta toda a configuração do projeto, carrega os módulos, resolve as variáveis, monta uma representação completa da infraestrutura desejada e somente então envia as instruções ao Provider responsável.

Essa arquitetura permite separar responsabilidades entre o projeto principal e os módulos, reutilizar código, padronizar ambientes e manter a infraestrutura organizada, características fundamentais para projetos profissionais de **Infrastructure as Code (IaC)**.
