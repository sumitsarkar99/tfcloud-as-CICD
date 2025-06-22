resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
  count             = 3
  cidr_block        = cidrsubnet("10.0.0.0/16", 8, count.index)
  vpc_id            = aws_vpc.main.id
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count             = 3
  cidr_block        = cidrsubnet("10.0.0.0/16", 8, count.index + 10)
  vpc_id            = aws_vpc.main.id
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}
