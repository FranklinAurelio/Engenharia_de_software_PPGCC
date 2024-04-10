resource "aws_ecr_repository" "ecr_repository" {
  name                 = "dengue-forecast"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}