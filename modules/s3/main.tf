# bucket 생성
resource "aws_s3_bucket" "terraform-state-bucket" {
  bucket = "terraform-state-bucket"

  tags = {
    Name        = "terraform-state-bucket"
  }
}

# S3 퍼블릭 접근 제한
resource "aws_s3_bucket_public_access_block" "terraform-state-bucket" {
  bucket = aws_s3_bucket.terraform-state-bucket.id

  block_public_acls       = true # S3 퍼블릭 ACL(Access Control List) 제한
  block_public_policy     = true # S3 퍼블릭 정책 제한
  ignore_public_acls      = true # S3 퍼블릭 ACL 무시하고, 버킷 접근 제한
  restrict_public_buckets = true # S3 퍼블릭 버킷 제한
}

# S3 버킷 객체 생성
resource "aws_s3_object" "terraform-state-object" {
  bucket = aws_s3_bucket.terraform-state-bucket.id # 업로드할 S3 버킷의 ID를 참조
  key    = "terraform/terraform.tfstate"           # S3 버킷 내에서 객체가 저장될 경로
  source = "terraform.tfstate"                     # 로컬 파일 시스템에서 업로드할 파일명
}

# DynamoDB 테이블 생성, Terraform 상태 파일 잠금 관리 및 사용자 동시성 제어
resource "aws_dynamodb_table" "terraform-state-lock" {
  name = "terraform-state-lock-${var.environment}"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}
