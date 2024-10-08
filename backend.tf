# 테라폼 상태를 저장하는 곳을 지정하는 파일이다.   
# 테라폼 상태는 테라폼 클라우드에서 관리하는 테라폼 작업의 이력과 상태를 저장하는 곳이다.  
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "global/s3/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
