resource "aws_apprunner_deployment" "apprunner_deployment" {
  service_arn = aws_apprunner_service.apprunner_service.arn
}

resource "aws_apprunner_connection" "apprunner_connection" {
  connection_name = "dengue-forecast-connection"
  provider_type   = "GITHUB"

  tags = {
    Name = "Conexão com o repositório github"
  }
}

resource "aws_apprunner_service" "apprunner_service" {
  service_name = "dengue-forecast-api"

  source_configuration {
    authentication_configuration {
      connection_arn = aws_apprunner_connection.apprunner_connection.arn
    }
    code_repository {
      code_configuration {
        code_configuration_values {
          build_command = "dotnet publish -c Release -o release"
          port          = "8000"
          runtime       = "DOTNET_6"
          start_command = "dotnet release/DengueForecastApi.dll --urls=http://0.0.0.0:8000"
        }
        configuration_source = "API"
      }
      repository_url = "https://github.com/FranklinAurelio/Engenharia_de_software_PPGCC"
      source_code_version {
        type  = "BRANCH"
        value = "develop"
      }
    }
  }

  health_check_configuration {
    healthy_threshold   = 1
    interval            = 5
    path                = "/hc"
    protocol            = "HTTP"
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