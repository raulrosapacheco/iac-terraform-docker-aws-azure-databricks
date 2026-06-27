# Tarefa 2 - Terraform com Arquivo de Variáveis `.tfvars`

## Sobre a Tarefa

Nesta tarefa, foi criado um novo laboratório Terraform dentro do container Docker utilizado no Lab 2.

O objetivo principal foi praticar a criação de uma infraestrutura usando Terraform, porém agora separando os valores das variáveis em um arquivo externo chamado `variaveis.tfvars`.

Essa abordagem melhora a organização do projeto, evita comandos muito longos e aproxima o laboratório de uma prática mais comum em projetos reais de Infrastructure as Code.

---

## Estrutura Criada

Dentro do container, na pasta `lab2`, foi criada uma nova pasta chamada `tarefa2`.

```bash
mkdir tarefa2
```

A estrutura esperada ficou semelhante a esta:

```text
lab2/
└── tarefa2/
    ├── main.tf
    ├── variaveis.tfvars
    └── README.md
```

---

## Instalação do Vim

Como os arquivos foram criados diretamente dentro do container, foi necessário instalar um editor de texto.

Primeiro, foi atualizado o índice de pacotes do sistema:

```bash
apt-get update
```

Depois, foi instalado o editor Vim:

```bash
apt-get install vim
```

Durante a instalação, foi confirmada a operação digitando:

```bash
y
```

---

## Criação do Arquivo `main.tf`

O arquivo `main.tf` foi criado com o editor Vim:

```bash
vi main.tf
```

Dentro do Vim, foi utilizado o modo de inserção para escrever o código Terraform.

Para entrar no modo de inserção:

```text
i
```

Após escrever o conteúdo do arquivo, foi pressionada a tecla `Esc` para sair do modo de inserção.

Para salvar o arquivo:

```text
:w
```

Para sair do Vim:

```text
:q
```

O arquivo `main.tf` é o principal arquivo de configuração do Terraform. Nele ficam definidos os recursos de infraestrutura que serão criados, como instâncias EC2, providers, região, tags e demais configurações.

---

## Criação do Arquivo `variaveis.tfvars`

Também foi criado um arquivo separado para armazenar os valores das variáveis:

```bash
vi variaveis.tfvars
```

Assim como no arquivo anterior, foi utilizado:

```text
i
```

para entrar no modo de inserção.

Depois de escrever os valores das variáveis, foi pressionado:

```text
Esc
```

Em seguida, o arquivo foi salvo com:

```text
:w
```

E fechado com:

```text
:q
```

O arquivo `variaveis.tfvars` é utilizado para armazenar os valores que serão passados para as variáveis declaradas no Terraform.

Exemplo:

```hcl
instance_type = "t3.micro"
ami           = "ami-xxxxxxxxxxxxxxxxx"
```

Com isso, não é necessário passar os valores diretamente no comando `terraform apply`.

---

## Diferença entre Variáveis no Comando e Arquivo `.tfvars`

Na tarefa anterior, as variáveis eram passadas diretamente no comando:

```bash
terraform apply -var="instance_type=t2.micro" -var="ami=ami-xxxxxxxxxxxxxxxxx"
```

Nesta tarefa, os valores foram separados em um arquivo `.tfvars`, permitindo executar o Terraform assim:

```bash
terraform apply -var-file="variaveis.tfvars"
```

Essa prática deixa o comando mais limpo e facilita a reutilização dos valores.

---

## Inicialização do Terraform

Depois da criação dos arquivos, foi executado o comando:

```bash
terraform init
```

Esse comando inicializa o diretório Terraform.

Durante essa etapa, o Terraform:

* identifica os arquivos `.tf`;
* baixa os providers necessários;
* cria a pasta `.terraform`;
* gera ou atualiza o arquivo `.terraform.lock.hcl`;
* prepara o diretório para execução dos próximos comandos.

---

## Aplicação da Infraestrutura

Para criar os recursos definidos no `main.tf`, foi executado:

```bash
terraform apply -var-file="variaveis.tfvars"
```

Esse comando aplica a configuração Terraform utilizando os valores definidos no arquivo `variaveis.tfvars`.

Durante a execução, o Terraform mostra um plano com os recursos que serão criados, alterados ou destruídos.

Para confirmar a criação da infraestrutura, é necessário digitar:

```text
yes
```

---

## Destruição da Infraestrutura

Após validar a criação dos recursos, foi executado o comando para destruir a infraestrutura:

```bash
terraform destroy -var-file="variaveis.tfvars"
```

Esse comando remove os recursos criados pelo Terraform, utilizando o mesmo arquivo de variáveis.

Assim como no `apply`, o Terraform solicita confirmação antes de destruir os recursos.

Para confirmar:

```text
yes
```

Essa etapa é importante para evitar custos desnecessários na AWS.

---

## Comandos Utilizados

Resumo dos principais comandos executados:

```bash
mkdir tarefa2

apt-get update

apt-get install vim

vi main.tf

vi variaveis.tfvars

terraform init

terraform apply -var-file="variaveis.tfvars"

terraform destroy -var-file="variaveis.tfvars"
```

---

## Comandos Básicos do Vim Utilizados

| Comando           | Função                         |
| ----------------- | ------------------------------ |
| `vi nome_arquivo` | Abre ou cria um arquivo no Vim |
| `i`               | Entra no modo de inserção      |
| `Esc`             | Sai do modo de inserção        |
| `:w`              | Salva o arquivo                |
| `:q`              | Sai do Vim                     |
| `:wq`             | Salva e sai ao mesmo tempo     |
| `:q!`             | Sai sem salvar                 |

---

## Conceitos Praticados

Nesta tarefa foram praticados os seguintes conceitos:

* Criação de diretórios no Linux;
* Instalação de pacotes dentro de um container;
* Uso básico do editor Vim;
* Criação de arquivos Terraform;
* Uso de arquivos `.tfvars`;
* Inicialização do Terraform;
* Aplicação de infraestrutura com `terraform apply`;
* Destruição de infraestrutura com `terraform destroy`;
* Separação entre código Terraform e valores de configuração.

---

## Boas Práticas Observadas

Separar variáveis em arquivos `.tfvars` é uma prática importante em projetos Terraform.

Isso permite:

* organizar melhor os valores de entrada;
* reutilizar configurações;
* criar arquivos diferentes para ambientes diferentes;
* evitar comandos longos;
* facilitar a manutenção do projeto.

Exemplo de organização por ambiente:

```text
terraform-project/
├── main.tf
├── variables.tf
├── dev.tfvars
├── homolog.tfvars
└── prod.tfvars
```

Cada ambiente pode ter seus próprios valores, como tipo de instância, AMI, região e tags.

---

## Observação Importante

Arquivos `.tfvars` podem conter informações sensíveis, como IDs, senhas, tokens ou configurações específicas de ambiente.

Em projetos reais, é comum não versionar arquivos `.tfvars` com dados sensíveis.

Uma boa prática é criar um arquivo de exemplo:

```text
terraform.tfvars.example
```

E adicionar o arquivo real ao `.gitignore`:

```text
*.tfvars
```

Assim, o projeto mantém um modelo de configuração sem expor informações importantes.

---

## Resultado

Ao final da tarefa, foi possível criar uma nova configuração Terraform utilizando um arquivo externo de variáveis, executar o provisionamento da infraestrutura e posteriormente destruir os recursos criados.

Essa tarefa reforça uma prática essencial em projetos de infraestrutura como código: manter o código separado dos valores de configuração.
