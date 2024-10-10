# AWS Jenkins CI/CD

> CI/CD deployment with Jenkins + Code Commit on AWS

## Terraform package

| 파일명            | 설명                                     |
|-------------------|------------------------------------------|
| `provider.tf`      | Terraform이 특정 클라우드 플랫폼과 통신하기 위한 모듈로 어떤 클라우드 플랫폼 사용할지 결정 |
| `ecs.tf`           | ECS 클러스터 및 서비스 정의 파일         |
| `alb.tf`           | Application Load Balancer 설정 파일      |
| `network.tf`       | 네트워크 구성 (VPC, 서브넷 등) 설정 파일|
| `security.tf`      | 보안 그룹 및 IAM 역할 설정 파일         |
| `auto_scaling.tf`  | 오토스케일링 설정 파일                   |
| `logs.tf`          | CloudWatch 로그 설정 파일               |
| `variables.tf`     | Terraform 변수 정의 파일                 |
| `outputs.tf`       | Terraform deploy 작업이 끝난 후 출력값 정의 |

## How to execute terrform?

> Jenkins CI/CD 테스트를 위해 간단한 ECS 환경을 구성하기 위해 Terraform 사용  

```shell
# move to module folder
cd ./modules
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