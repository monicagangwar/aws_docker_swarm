resource "aws_subnet" "manager_subnet" {
  count             = "${var.manager_count}"
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${element(var.manager_subnet_zones, count.index)}"
  cidr_block        = "${element(var.manager_subnet_cidr, count.index)}"

  tags {
    Name = "manager_subnet_${count.index}"
  }
}

resource "aws_route_table_association" "manager_route_table_association" {
  count          = "${var.manager_count}"
  subnet_id      = "${element(aws_subnet.manager_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route.id}"
}

output "manager_subnet_ids" {
  value = ["${aws_subnet.manager_subnet.*.id}"]
}
