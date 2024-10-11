variable "domain" {
  description = "서비스 메인 이름 지정"
  type        = string
  default     = "search"
}

variable "environment" {
  description = "개발 환경 변수"
  type        = string
}
