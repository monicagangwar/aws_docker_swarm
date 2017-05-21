data "terraform_remote_state" "global" {
  backend = "s3"

  config {
    bucket = "mon_terraform_tfstate_bucket"
    key    = "global/terraform.tfstate"
    region = "us-east-1"
  }
}
