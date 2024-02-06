terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.35"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

locals {
  seller_ids = jsondecode(file("./seller_ids.json"))
}

resource "aws_sqs_queue" "terraform_queue" {
  for_each = toset(local.seller_ids)
  name     = "sp-api-seller-${each.key}"
}
