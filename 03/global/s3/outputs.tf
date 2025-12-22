#output "myburcket_arn" {
# value = aws_s3_bucket.mytfstate.arn
#}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.my_tflocks.name
}