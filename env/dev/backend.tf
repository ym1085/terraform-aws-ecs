# # dynamodb_table: 이미 존재하는 DynamoDB 테이블을 사용하여, Terraform 상태 파일 잠금 관리하는 역할
# # backend: Terraform 상태 파일을 S3에 저장하고, DynamoDB를 사용하여 동시성 제어
# # backend 파일의 경우 우선 S3 버킷을 먼저 생성(modules/s3/main.tf - terraform init)한 후에 주석 해제 및 작업 진행 필요
# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-bucket"       # s3 버킷명
#     key            = "terraform/terraform.tfstate"  # s3에 저장 파일 경로(폴더명/파일명)
#     region         = "ap-northeast-2"               # s3 리전
#     encrypt        = true                           # s3에 저장되는 terraform.tfstate 파일 암호화
#     dynamodb_table = "tfstate-lock"                 # DynamoDB 테이블명, DynamoDB 테이블을 사용한 잠금 기능(동시성 제어)
#   }
# }