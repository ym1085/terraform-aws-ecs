# Terraform ECS

## Why use Terraform this repository?

I found making resources in the console was inefficient, so I used IaC tools instead.

## Project Structure

```shell
TERAFORM-ECS-FARGATE/
├── env/
│   ├── dev/
│   │   ├── .terraform.lock.hcl
│   │   ├── graph.dot
│   │   ├── alias.sh
│   │   ├── graph.sh
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   │   └── backend.tf
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
│   ├── s3/
│   │   ├── main.tf
│   │   ├── outputs.tf
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

## How to run this project?

```shell
# you must create aws iam user and have access key id & secret access key
# In a production environment, role-based is recommended,
# long-term security credentials are risky.
$ aws configure
AWS Access Key ID [None]: YOUR_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_SECRET_ACCESS_KEY
Default region name [None]: ap-northeast-2
Default output format [None]: json
```

```shell
# check aws account info
$ aws sts get-caller-identity
{
    "UserId": "AIDXXXXXXXXXXXXXX",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/YourUserName"
}
```

```shell
# move to /env/dev folder
cd env/dev
```

```shell
# setting env variable to terraform.tfvars file
cat <<EOF > terraform.tfvars
vpc_cidr_block = "172.21.0.0/16"
vpc_name       = "search-vpc-dev"

az_count    = 2
environment = "dev"

alb_listener_port = "80"
container_port    = 3000

# Private ECR Repository Image ARN
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
# validate terraform file
$ terraform validate
```

```shell
# check terraform plan
$ terraform plan
```

```shell
# check terraform graph
# you must install 'graphviz' to see graph
$ terraform graph > graph.dot
```

```shell
# apply & deploy terraform resource
$ terraform apply
```

```shell
# destory all terraform resource
$ terraform destroy
```

## Reference

- [Hashicorp Terraform installation](https://developer.hashicorp.com/terraform/install)
- [Terraform registry documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Deploying Containers on Amazon’s ECS using Fargate and Terraform](https://medium.com/@bradford_hamilton/deploying-containers-on-amazons-ecs-using-fargate-and-terraform-part-2-2e6f6a3a957f)
- [Curly - A DevOps team's Terraform adventure](https://helloworld.kurly.com/blog/terraform-adventure)
