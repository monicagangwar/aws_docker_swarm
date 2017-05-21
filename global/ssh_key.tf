resource "aws_key_pair" "ssh" {
  key_name   = "mon"
  public_key = "${file("~/.ssh/mon.pub")}"
}

output "ssh_key" {
  value = "${aws_key_pair.ssh.key_name}"
}
