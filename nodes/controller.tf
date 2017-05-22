resource "aws_instance" "controller" {
  count = 1
  ami             = "${lookup(var.amis, var.region)}"
  instance_type   = "t2.micro"
  subnet_id       = "${element(data.terraform_remote_state.vpc.controller_subnet_ids, count.index)}"
  key_name        = "${data.terraform_remote_state.global.ssh_key}"
  vpc_security_group_ids = ["${aws_security_group.controller.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  user_data       = "${data.template_cloudinit_config.controller.rendered}"

  tags {
    Name = "controller"
  }
}

resource aws_security_group "controller" {
  name        = "controller"
  description = "Security group for docker controller node"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

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
