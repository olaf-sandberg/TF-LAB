resource "aws_networkmanager_core_network_policy_attachment" "policy" {
  core_network_id = var.core_network_id
  policy_document = file(var.policy_path)
}