resource "aws_subnet" "worker_subnet" {
  count             = "${var.worker_count}"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${element(var.worker_subnet_zones, count.index)}"
  cidr_block        = "${element(var.worker_subnet_cidr, count.index)}"

  tags {
    Name = "worker_subnet_${count.index}"
  }
}
resource "aws_route_table" "worker_route" {
  count = "${var.worker_count}"
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}
resource "aws_route_table_association" "worker_route_table_association" {
  count          = "${var.worker_count}"
  subnet_id      = "${element(aws_subnet.worker_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_route.id}"
}

output "worker_subnet_ids" {
  value = ["${aws_subnet.worker_subnet.*.id}"]
}
