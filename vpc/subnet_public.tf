resource "aws_subnet" "public_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  availability_zone = "${var.public_subnet_zone}"
  cidr_block        = "${var.public_subnet_cidr}"

  tags {
    Name = "public_subnet"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_route.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}
