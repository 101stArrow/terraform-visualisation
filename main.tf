terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "work"
  region  = "eu-west-2"
}

provider "aws" {
  alias  = "us"
  profile = "work"
  region  = "us-east-1"
}