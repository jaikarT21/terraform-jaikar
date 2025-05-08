resource "aws_launch_template" "lt" {
  name_prefix   = "tf-lt-"
  image_id      = "ami-0f88e80871fd81e91" # Amazon Linux 2 for us-east-1
  instance_type = var.instance_type
  key_name      = aws_key_pair.tf-key.key_name

  vpc_security_group_ids = [aws_security_group.sg.id]


}
