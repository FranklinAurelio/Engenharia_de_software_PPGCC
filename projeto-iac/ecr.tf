resource "aws_ecr_repository" "ecr_repository" {
  name                 = "dengue-forecast-repositorio"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
