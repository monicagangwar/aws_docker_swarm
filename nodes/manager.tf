resource "aws_instance" "manager" {
  count                       = 1
  ami                         = "${lookup(var.amis, var.region)}"
  instance_type               = "t2.micro"
  subnet_id                   = "${element(data.terraform_remote_state.vpc.manager_subnet_ids, count.index)}"
  key_name                    = "${data.terraform_remote_state.global.ssh_key}"
  vpc_security_group_ids      = ["${aws_security_group.manager.id}"]
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = "${data.template_cloudinit_config.manager.rendered}"

  tags {
    Name = "manager"
  }
}

resource aws_security_group "manager" {
  name        = "manager"
  description = "Security group for docker manager node"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

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
