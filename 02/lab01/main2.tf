####################################################
# 1. SG 
# 2. EC2
####################################################

####################################################
# 1. SG
####################################################
# SG
# * ingress: 80/tcp, 443/tcp
# * engress: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "mySG" {
  name        = "mySG"
  description = "Allow TLS inbound 80/tcp, 443/tcp and all outbound traffic"
  vpc_id      = aws_vpc.myVPC.id

  tags = {
    Name = "mySG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "mySG_80" {
  security_group_id = aws_security_group.mySG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "mySG_443" {
  security_group_id = aws_security_group.mySG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "mySG_all" {
  security_group_id = aws_security_group.mySG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

####################################################
# 2. EC2
####################################################
# EC2
# *
# * security group{mySG} 
# * user_data{80/tcp, 443/tcp}
#   => user_data 변경이 되면 EC2 재생성하도록 설정 
resource "aws_instance" "myEC2" {
  ami           = "ami-00e428798e77d38d9"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.mySG.id]
  user_data_replace_on_change = true
  user_data = <<-EOF
    #!/bin/bash
    dnf -y install httpd mod_ssl
    echo "MyWEB" > /var/www/html/index.html
    systemctl enable --now httpd 
    EOF
  subnet_id = aws_subnet.myPubSN.id
  tags = {
    Name = "myEC2"
  }
}
