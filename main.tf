terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "tf-state-bucket" {
  bucket = "aws-nsoungadoy2-bbg-tf-state"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Group = "Infra"
  }
}

resource "aws_dynamodb_table" "tf-state-lock-table" {
  name           = "tf-state-lock"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Group = "Infra"
  }
}
