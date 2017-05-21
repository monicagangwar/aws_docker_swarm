resource "aws_s3_bucket" "terraform_tfstate_bucket" {
  bucket = "mon_terraform_tfstate_bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}
