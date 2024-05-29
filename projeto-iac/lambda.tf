data "archive_file" "lambda_artefact" {
  type        = "zip"
  source_dir  = "../projeto-ia"
  output_path = "files/lambda_function_payload.zip"
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = "DengueForecastAiModel"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  timeout          = 20
  memory_size      = 128
  role             = aws_iam_role.iam_role_lambda.arn
  filename         = data.archive_file.lambda_artefact.output_path
  source_code_hash = data.archive_file.lambda_artefact.output_base64sha256
}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = aws_lambda_function.lambda_function.function_name
  authorization_type = "NONE"
}
