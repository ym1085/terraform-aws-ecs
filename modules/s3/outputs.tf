# s3 버킷명
output "bucket_name" {
  value = aws_s3_bucket.terraform-state-bucket.bucket
}

# s3 객체 URL
output "s3_object_url" {
  value = aws_s3_object.terraform-state-object.id
}