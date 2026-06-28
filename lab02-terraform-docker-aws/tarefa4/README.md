docker ps

docker exec -it lab2 /bin/bash

cd lab2

mkdir tarefa4

cd tarefa4

vi main.tf
i
esc
:wq

vi outputs.tf
i
esc
:wq

ls

mkdir modules

cd modules

mkdir ec2-instances

cd ec2-instances

vi variables.tf
i
esc
:wq

vi main.tf
i
esc
:wq

vi outputs.tf
i
esc
:wq

cat outputs.tf (para visualizar)

cat main.tf (para visualizar)

cat variables.tf (para visualizar)

em /lab2/tarefa4

terraform init

terraform apply

terraform output

terraform output instance_ids (caso tenha varios outputs)

terraform destroy 

