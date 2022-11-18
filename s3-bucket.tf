resource "aws_s3_bucket" "bkt2" {
  bucket = "terra-bucket220001"

  tags = {
    Name        = "terraform"
    Environment = "script"
  }
}

resource "aws_s3_bucket_acl" "acl_bkt1" {
  bucket = aws_s3_bucket.bkt2.id
  acl    = "public-read"
}
