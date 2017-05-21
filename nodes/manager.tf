resource "aws_instance" "manager" {
  ami             = "${lookup(var.amis, var.region)}"
  instance_type   = "t2.micro"
  availability_zone = "us-east-1a"
  key_name        = "${data.terraform_remote_state.global.ssh_key}"
  security_groups = ["${aws_security_group.manager.name}"]
  user_data       = "${data.template_cloudinit_config.manager.rendered}"

  tags {
    Name = "manager"
  }
}

resource aws_security_group "manager" {
  name        = "manager"
  description = "Security group for docker manager node"

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

output "manager_ip" {
  value = "${aws_instance.manager.public_ip}"
}
