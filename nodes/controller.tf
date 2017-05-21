resource "aws_instance" "controller" {
  ami             = "${lookup(var.amis, var.region)}"
  instance_type   = "t2.micro"
  availability_zone = "us-east-1a"
  key_name        = "${data.terraform_remote_state.global.ssh_key}"
  security_groups = ["${aws_security_group.controller.name}"]
  user_data       = "${data.template_cloudinit_config.controller.rendered}"

  tags {
    Name = "controller"
  }
}

resource aws_security_group "controller" {
  name        = "controller"
  description = "Security group for docker controller node"

  ingress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "controller_ip" {
  value = "${aws_instance.controller.public_ip}"
}
