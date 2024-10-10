terraform {
  backend "s3" {
    bucket = "[your-bucket-terraform]"
    key    = "GitHub/Buckets/[bucket-name]/terraform.tfstate"
    region = "us-east-1"
  }
}
