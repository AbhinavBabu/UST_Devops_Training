resource "aws_subnet" "all" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value.cidr_offset)
  availability_zone       = data.aws_availability_zones.available.names[each.value.az_index]
  map_public_ip_on_launch = each.value.type == "public" ? true : false

  tags = merge(
    {
      Name = "${var.vpc_name}-${each.key}"
      Type = each.value.type
      "kubernetes.io/cluster/${var.vpc_name}" = "shared"
    },
    each.value.type == "public" ? {
      "kubernetes.io/role/elb" = "1"
    } : {},
    each.value.type == "app" ? {
      "kubernetes.io/role/internal-elb" = "1"
    } : {}
  )
}