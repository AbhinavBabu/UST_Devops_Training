resource "aws_eip" "nat" {
  count = 2

  domain = "vpc"

  tags = {
    Name = "${var.vpc_name}-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "main" {
  count = 2

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.all["public-${count.index + 1}"].id

  depends_on = [aws_internet_gateway.main]

  tags = {
    Name = "${var.vpc_name}-nat-${count.index + 1}"
  }
}