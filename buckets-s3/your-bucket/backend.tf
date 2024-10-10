terraform {
  backend "s3" {
    bucket = "nic-terraform"
    key    = "GitHub/Buckets/test-nic-23/terraform.tfstate"
    region = "us-east-1"
  }
}
