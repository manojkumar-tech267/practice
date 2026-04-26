resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = local.vpc_final_tags
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = local.igw_final_tags
}


resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)  
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.az_info[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-public-${local.az_info[count.index]}"
    },
    var.public_subnet_tags
  )
}


resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_info[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-private-${local.az_info[count.index]}"
    },
    var.private_subnet_tags
  )
}


resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone = local.az_info[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-database-${local.az_info[count.index]}"
    },
    var.database_subnet_tags
  )
}



resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = local.public_route_table_final_tags
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = local.private_route_table_final_tags
}


resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = local.database_route_table_final_tags
}



resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}


resource "aws_eip" "nat" {
  domain   = "vpc"
  tags = local.eip_final_tags
}


resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = local.nat_gateway_final_tags

  depends_on = [aws_internet_gateway.main]
}


resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_tags)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}
