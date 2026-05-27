resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id 

  route {
    gateway_id = aws_internet_gateway.main.id 
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each = {
    for key, subnet in aws_subnet.all :
    key => subnet
    if subnet.tags.Type == "public"
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  count = 2

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "${var.vpc_name}-app-rt-${count.index + 1}"
  }
}

resource "aws_route_table_association" "private" {
  for_each = {
    for key, subnet in aws_subnet.all :
    key => subnet
    if subnet.tags.Type == "app"
  }

  subnet_id = each.value.id

  route_table_id = aws_route_table.private[
    each.value.availability_zone == data.aws_availability_zones.available.names[0] ? 0 : 1
  ].id
}

resource "aws_route_table" "db" {
  count = 2

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-db-rt-${count.index + 1}"
  }
}

resource "aws_route_table_association" "db" {
  for_each = {
    for key, subnet in aws_subnet.all :
    key => subnet
    if subnet.tags.Type == "db"
  }

  subnet_id = each.value.id

  route_table_id = aws_route_table.db[
    each.value.availability_zone == data.aws_availability_zones.available.names[0] ? 0 : 1
  ].id
}