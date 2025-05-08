
resource "aws_key_pair" "tf-key" {
  key_name   = "tf-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQMNu6YonS37prHSE3APUNkEDoeYbCR2qJLAWglbUpO"
}
