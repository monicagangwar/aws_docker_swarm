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

data "template_file" "worker" {
  template = "${file("cloud-config/worker.cfg")}"

  vars {
    manager = "${aws_instance.manager.private_ip}"
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
