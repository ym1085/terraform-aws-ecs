# Terraform ECS & Jenkins

> Terraoforming for ecs environment configuration during jenkins configuration

## Terraform package structure

```shell
TERAFORM-ECS-FARGATE/
├── env/
│   ├── dev/
│   │   ├── .terraform.lock.hcl
│   │   ├── graph.dot
│   │   ├── graph.sh
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   ├── qa/
│   └── stg/
├── jenkins/
├── modules/
│   ├── alb/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ecs/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── task_definitions_bak.tpl
│   │   ├── task_definitions.tpl
│   │   └── variables.tf
│   ├── gateway/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── route_tables/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── security_groups/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── subnets/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── .gitignore
└── README.md
```

## How to execute terrform?

> Jenkins CI/CD 테스트를 위해 간단한 ECS 환경을 구성하기 위해 Terraform 사용

```shell
# move to module folder
cd ./env/dev
```

```shell
# setting env variable to terraform.tfvars file
cat <<EOF > terraform.tfvars
vpc_cidr_block = "172.21.0.0/16"
vpc_name       = "test_vpc"

az_count    = 2
environment = "dev"

alb_listener_port = "80"
container_port    = 3000
container_image   = "6xxxxxxxxxxxxx.dkr.ecr.ap-northeast-2.amazonaws.com/nodejs"

ecs_fargate_task_total_cpu = 2048
ecs_fargate_task_total_mem = 1024
ecs_task_desired_count     = 1
domain                     = "search"
EOF
```

```shell
# initialize terraform project
$ terraform init
```

```shell
# check terraform plan
$ terraform plan
```

```shell
# apply terraform resource
$ terraform apply
```

## Reference

- [Hashicorp Terraform installation](https://developer.hashicorp.com/terraform/install)
- [Deploying Containers on Amazon’s ECS using Fargate and Terraform: Part 2](https://medium.com/@bradford_hamilton/deploying-containers-on-amazons-ecs-using-fargate-and-terraform-part-2-2e6f6a3a957f)
- [Curly - A DevOps team's Terraform adventure](https://helloworld.kurly.com/blog/terraform-adventure)
