// VPC
resource "aws_vpc" "mc_vpc" {
  cidr_block = var.CIDR_BLOCK
}

// Security Group
resource "aws_security_group" "mc_vpc_security_group" {
    vpc_id      = aws_vpc.mc_vpc.id
    ingress {
        from_port   = var.MINECRAFT_SERVER_PORT
        to_port     = var.MINECRAFT_SERVER_PORT
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port        = var.MINECRAFT_SERVER_PORT
        to_port          = var.MINECRAFT_SERVER_PORT
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }
}


resource "aws_subnet" "mc_vpc_subnet" {
  vpc_id     = aws_vpc.mc_vpc.id
  cidr_block = var.SUBNET_CIDR_BLOCK
}

# // EC2 Instance
# resource "aws_instance" "mc_instance" {
#   ami               = data.aws_ami.MC_AMI
#   availability_zone = var.default_region
#   instance_type     = var.instance_type
# }

# // EBS Volume
# resource "aws_ebs_volume" "mc_ebs_volume" {
#   availability_zone = var.default_region
#   size              = var.storage_volume_size
# }

# // EBS Volume attachment
# resource "aws_volume_attachment" "mc_ebs_volume_attach" {
#   device_name = var.EBS_DEVICE_NAME
#   volume_id   = aws_ebs_volume.mc_ebs_volume.id
#   instance_id = aws_instance.mc_instance.id
# }

# // EBS Volume back up
# resource "aws_ebs_snapshot" "mc_ebs_volume_snapshot" {
#   volume_id = aws_ebs_volume.mc_ebs_volume.id
#   storage_tier = var.EBS_SNAPSHOT_STORAGE_TIER
# }

// Lambda
resource "aws_lambda_function" "vpc_logs_monitoring_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.LAMBDA_FUNCTION_NAME
  role          = aws_iam_role.mc_vpc_monitoring_lambda.arn
  handler       = var.LAMBDA_FUNCTION_HANDLER_NAME
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime = var.LAMBDA_RUNTIME_VERSION

   environment {
    variables = {
      CLOUDWATCH_LOG_GROUP = var.CLOUDWATCH_LOG_GROUP
      LOG_STREAM_NAME = var.LOG_STREAM_NAME
    }
  }

  vpc_config {
    subnet_ids = [aws_subnet.mc_vpc_subnet.id]
    security_group_ids = [aws_security_group.mc_vpc_security_group.id]
  }
}

// Lambda role to monitor VPC
resource "aws_iam_role" "mc_vpc_monitoring_lambda" {
  name               = "mc_vpc_monitoring_lambda"
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
        Action   = var.LAMBDA_PERMISSIONS
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_cloudwatch_event_rule" "vpc_monitoring_rule" {
  name                = "vpc-active-connections-monitoring-lambda-rule"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.vpc_monitoring_rule.name
  target_id = "lambda-target"
  arn       = aws_lambda_function.vpc_logs_monitoring_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge_invoke" {
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = aws_lambda_function.vpc_logs_monitoring_lambda.function_name
  source_arn    = aws_cloudwatch_event_rule.vpc_monitoring_rule.arn
}