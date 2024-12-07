// Lambda
resource "aws_lambda_function" "turn_off_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.LAMBDA_FUNCTION_NAME
  role          = aws_iam_role.mc_vpc_monitoring_lambda.arn
  handler       = "${var.LAMBDA_FUNCTION_NAME}.${var.LAMBDA_FUNCTION_HANDLER_NAME}"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  timeout = 120
  runtime = var.LAMBDA_RUNTIME_VERSION

   environment {
    variables = {
      CLOUDWATCH_LOG_GROUP = var.CLOUDWATCH_LOG_GROUP
      LOG_STREAM_NAME = var.LOG_STREAM_NAME
      INSTANCE_ID = aws_instance.mc_instance.id
    }
  }

  vpc_config {
    subnet_ids = [aws_subnet.mc_vpc_subnet.id]
    security_group_ids = [aws_security_group.mc_vpc_security_group.id]
  }
}

// Lambda
resource "aws_lambda_function" "turn_on_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.LAMBDA_FUNCTION_NAME
  role          = aws_iam_role.mc_vpc_monitoring_lambda.arn
  handler       = "${var.LAMBDA_FUNCTION_NAME}.${var.LAMBDA_FUNCTION_HANDLER_NAME}"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  timeout = 120
  runtime = var.LAMBDA_RUNTIME_VERSION

   environment {
    variables = {
      CLOUDWATCH_LOG_GROUP = var.CLOUDWATCH_LOG_GROUP
      LOG_STREAM_NAME = var.LOG_STREAM_NAME
      INSTANCE_ID = aws_instance.mc_instance.id
    }
  }

  vpc_config {
    subnet_ids = [aws_subnet.mc_vpc_subnet.id]
    security_group_ids = [aws_security_group.mc_vpc_security_group.id]
  }
}

// Lambda role to monitor VPC
resource "aws_iam_role" "mc_vpc_monitoring_lambda" {
  name               = var.VPC_MONITORING_LAMBDA_ROLE_NAME
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_monitoring_policy_attachment" {
  role       = aws_iam_role.mc_vpc_monitoring_lambda.name
  policy_arn = aws_iam_policy.lambda_vpc_monitoring_policy.arn
}

// Lambda Role policy to monitor VPC logs to shut down
resource "aws_iam_policy" "lambda_vpc_monitoring_policy" {
  name        = "LambdaVPCMonitoringPolicy"
  description = "Policy that allows Lambda to read data and shut down EC2 instances"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = var.LAMBDA_EXECUTE_PERMISSIONS
        Effect   = "Allow"
        Resource = "*"
      },
      {
      Effect = "Allow",
      Action = var.LAMBDA_LOGGING_PERMISSIONS,
      Resource = var.LOGS_ARN_WILDCARD
    }
    ]
  })
}

resource "aws_cloudwatch_log_group" "vpc_monitoring_lambda_log_group" {
  name              = var.LOGS_GROUP_PATH
  retention_in_days = 14
}