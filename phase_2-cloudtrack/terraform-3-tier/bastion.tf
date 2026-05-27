resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.all["public-1"].id

  vpc_security_group_ids = [aws_security_group.bastion.id]

  associate_public_ip_address = true

  key_name = var.key_name

  tags = {
    Name = "${var.vpc_name}-bastion"
  }
}