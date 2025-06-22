resource "aws_launch_template" "web" {
  name_prefix   = "webserver-"
  image_id      = "ami-09e6f87a47903347c"
  instance_type = "t2.micro"
  key_name      = var.key_name
}

resource "aws_autoscaling_group" "web_asg" {
  vpc_zone_identifier = var.private_subnet_ids
  desired_capacity    = 2
  min_size            = 1
  max_size            = 3

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]
  health_check_type = "EC2"
}
