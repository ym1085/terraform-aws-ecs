# provider는 terraform에서 사용할 클라우드 서비스를 정의하는 곳이다
terraform {
  required_version = ">= 1.9.7" // Terraform 버전 요구사항
  required_providers {
    aws = {
      source  = "hashicorp/aws" // AWS 제공자
      version = "~> 4.0"        // AWS 제공자 버전
    }
  }
}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
  region                   = var.aws_region
}

# 전역 변수
variable "aws_region" {
  description = "AWS 리전"
  default     = "ap-northeast-2"
}
