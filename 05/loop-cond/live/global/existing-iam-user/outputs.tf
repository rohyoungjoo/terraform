output "all" {
  value = aws_iam_user.createuser[*].id
}