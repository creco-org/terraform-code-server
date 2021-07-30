provider "aws" {
  region = var.region
}

resource "aws_security_group" "code_server_security" {
  name        = "code_server_security"
  description = "code_server_security"
  dynamic "ingress" {
    for_each = var.service_ports
    content {
      description      = "Port: ${ingress.value}"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "code_server" {
  # ami                    = "ami-0b827f3319f7447c6"
  ami                    = "ami-0b1f6dadd6c912cca"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.code_server_security.id]
  tags = {
    Name = "terraform-code-server"
  }
  key_name = aws_key_pair.code_server.key_name
  provisioner "file" {
    source      = "./code-server.sh"
    destination = "/tmp/code-server.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "export password=${var.password}",
      "chmod +x /tmp/code-server.sh",
      "sudo /tmp/code-server.sh",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = ""
    private_key = file(var.key_pair_filename)
    host        = self.public_ip
  }
}

resource "aws_key_pair" "code_server" {
  key_name   = var.key_pair_name
  public_key = var.key_pair_public_key
}
variable "service_ports" {
  default = [22, 8443, 80, 8080]
}
output "welcome_to_code_server" {
  value = "http://${aws_instance.code_server.public_ip}"
}
variable "password" {}
variable "key_pair_name" {}
variable "key_pair_filename" {}
variable "key_pair_public_key" {}
variable "region" {
  default = "ap-northeast-2"
}
