resource "aws_launch_template" "this" {
  name_prefix   = "${var.name_prefix}-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y httpd
echo "healthy" > /var/www/html/healthz
systemctl enable httpd
systemctl start httpd
EOF
  )

  vpc_security_group_ids = [var.security_group_id]
}
