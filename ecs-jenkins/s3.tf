resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-innowi-a2b6219"

  tags = {
    Name = "Terraform state"
  }
}

