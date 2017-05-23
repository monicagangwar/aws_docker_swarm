provider "cloudinit" {}

data "template_cloudinit_config" "controller" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${file("cloud-config/controller.cfg")}"
  }
}

data "template_cloudinit_config" "manager" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${file("cloud-config/manager.cfg")}"
  }
}
data "template_file" "swarm_token" {
  template = "${file("cloud-config/swarm_token.sh")}"

  vars {
    manager     = "${aws_instance.manager.public_ip}"
  }
}

data "template_file" "worker" {
  template = "${file("cloud-config/worker.cfg")}"

  vars {
    swarm_token = "${base64encode("${data.template_file.swarm_token.rendered}")}"
  }
}

data "template_cloudinit_config" "worker" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.worker.rendered}"
  }
}
