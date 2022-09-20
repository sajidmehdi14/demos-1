terraform {
  backend "s3" {
    bucket = "terraform-state-innowi-a2b6219"
    key    = "terraform.tfstate"
    region = "us-west-1"
  }
}
