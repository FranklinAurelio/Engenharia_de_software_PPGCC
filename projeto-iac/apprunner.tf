resource "aws_apprunner_service" "apprunner" {
  service_name = ""

  source_configuration {
    authentication_configuration {
      connection_arn = "" # Inserir o arn da conexão do app runner com o repositório.
    }
    code_repository {
      code_configuration {
        code_configuration_values {
          build_command = "dotnet publish -c Release -o release"
          port          = "8000"
          runtime       = "DOTNET_6"
          start_command = "dotnet release/XXXXXXXXXXX.dll --urls=http://0.0.0.0:8000"
        }
        configuration_source = "API"
      }
      repository_url = "https://github.com/FranklinAurelio/Engenharia_de_software_PPGCC"
      source_code_version {
        type  = "BRANCH"
        value = "main"
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

  network_configuration {
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = "" # Inserir o arn do vpc connector.
    }
  }

  instance_configuration {
    cpu    = 512
    memory = 1024
  }

  tags = {
    gerenciado-por = "terraform"
  }
}