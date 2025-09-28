terraform {
  backend "s3" {
    bucket = "mini-dft-project-bucket"
    key    = "Miniproject/terraform.tfstate"
    region = "us-west-1"
    encrypt = true
  }
}
  provider "aws" {
  region     = "us-west-1"
}

