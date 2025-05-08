
# resource "aws_s3_bucket" "tf-s3" {
#   bucket = "Rohithevx-tf-s3"
# }

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = "rohithdevx-tf-s3-${random_id.bucket_suffix.hex}"

  tags = {
    Name = "rohithdevx-tf-s3"
  }
}
