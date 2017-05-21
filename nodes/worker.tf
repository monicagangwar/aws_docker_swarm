resource "aws_instance" "worker" {
  count           = 2
  ami             = "${lookup(var.amis, var.region)}"
  instance_type   = "t2.micro"
  availability_zone = "us-east-1a"
  key_name        = "${data.terraform_remote_state.global.ssh_key}"
  security_groups = ["${aws_security_group.worker.name}"]
  user_data       = "${data.template_cloudinit_config.worker.rendered}"

  tags {
    Name = "worker-${count.index}"
  }
}

resource aws_security_group "worker" {
  name        = "worker"
  description = "Security group for docker worker node"

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
