resource "aws_apprunner_deployment" "apprunner_deployment" {
  service_arn = aws_apprunner_service.apprunner_service.arn
}

resource "aws_apprunner_service" "apprunner_service" {
  service_name = "DengueForecastApi"
  source_configuration {
    image_repository {
      image_configuration {
        port = "80"
      }
      image_identifier      = "271525114120.dkr.ecr.us-east-1.amazonaws.com/dengue-forecast-repositorio:latest"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = true
    authentication_configuration {
      access_role_arn = "arn:aws:iam::271525114120:role/service-role/AppRunnerECRAccessRole"
    }
  }

  health_check_configuration {
    healthy_threshold   = 1
    interval            = 5
    path                = "/"
    protocol            = "TCP"
    timeout             = 2
    unhealthy_threshold = 5
  }

  instance_configuration {
    cpu    = 512
    memory = 1024
  }

  tags = {
    gerenciado-por = "terraform"
  }
}