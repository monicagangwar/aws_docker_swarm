resource "aws_subnet" "controller_subnet" {
  count             = "${var.controller_count}"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${element(var.controller_subnet_zones, count.index)}"
  cidr_block        = "${element(var.controller_subnet_cidr, count.index)}"

  tags {
    Name = "controller_subnet_${count.index}"
  }
}

resource "aws_route_table_association" "controller_route_table_association" {
  count          = "${var.controller_count}"
  subnet_id      = "${element(aws_subnet.controller_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route.id}"
}

output "controller_subnet_ids" {
  value = ["${aws_subnet.controller_subnet.*.id}"]
}
