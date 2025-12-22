provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_user" "createuser" {
  count = length(var.user_names)

  name = var.user_names[count.index]
}

