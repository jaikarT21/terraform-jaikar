
resource "aws_autoscaling_group" "asg" {
  name                = "tf-asg"
  min_size            = 2
  max_size            = 5
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tg.arn]

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300
}
