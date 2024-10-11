resource "aws_s3_bucket" "s3" {
bucket = "${var.domain}-${var.environment}-bucket"

  tags = {
    Name        = "${var.domain}-${var.environment}-bucket"
    Environment = var.environment
  }
}
