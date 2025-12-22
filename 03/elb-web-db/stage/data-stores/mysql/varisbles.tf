variable "dbuser" {
  description = "DB username(ex: dbuser)"
  type = string
  sensitive = true
}

variable "dbpassword" {
  description = "DB dbpassword(ex: @password)"
  type = string
  sensitive = true
}