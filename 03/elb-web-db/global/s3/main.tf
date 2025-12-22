###################################
# 1. provider 
# 2. S3 myburcket 생성
# 3. DynamoDB 생성(LockID)
###################################

###################################
# 1. provider 설정
###################################
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.26.0"
    }
  }
  backend "s3" {
    bucket = "myroh-0126" 
    key    = "global/s3/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "mylocktable"
  }
}

provider "aws" {
  region = "us-east-2"
}

###################################
# 2. S3 myburcket 생성
###################################
resource "aws_s3_bucket" "mytfstate" {
  bucket = "myroh-0126"

  tags = {
    Name        = "mytfstate"
  }
}

###################################
# 3. DynamoDB 생성(LockID)
###################################
# * S3 burcket ARN -> output
# * DynamoDB table name -> output
resource "aws_dynamodb_table" "mylocktable" {
  name           = "mylocktable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "mylocktable"
  }
}