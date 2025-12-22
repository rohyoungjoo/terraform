##########################################
# 1. S3 burcket 생성
# 2. DynamoDB Table 생성
##########################################]
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
# resource "aws_s3_bucket" "mytfstate" {
# bucket = "roh-0126"

# tags = {
#  Name        = "roh-0126"
# }
#}

#
resource "aws_dynamodb_table" "my_tflocks" {
  name           = "my_tflocks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
 
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "my_tflocks"
  }
}