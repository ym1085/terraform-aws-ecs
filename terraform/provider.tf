# provider.tf
# provider는 terraform에서 사용할 클라우드 서비스를 정의하는 곳이다
# 클라우드 서비스에 대한 인증 정보를 제공하고, 특정 지역이나 계정을 선택하는 등의 설정 가능
provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
  region                   = "var.aws_region"
}