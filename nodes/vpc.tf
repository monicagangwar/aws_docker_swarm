data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "mon_terraform_tfstate_bucket"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}
