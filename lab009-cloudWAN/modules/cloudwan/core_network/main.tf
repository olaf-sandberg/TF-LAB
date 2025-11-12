resource "aws_networkmanager_global_network" "this" {
  description = "${var.project} global network"
}

resource "aws_networkmanager_core_network" "this" {
  global_network_id = aws_networkmanager_global_network.this.id
  description        = "${var.project} core network"

  tags = {
    Name = "${var.project}-core-network"
  }
}

output "core_network_id" {
  value = aws_networkmanager_core_network.this.id
}