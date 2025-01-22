# // INPUT BASED VARIABLES
# variable default_region {
#     default = "us-east-2"
#     type = string
# }

# variable storage_volume_size {
#     default = 4
#     type = number
# }

# variable instance_type {
#     default = "t2.micro"
#     type = string
# }











# // HARD CODED VARIABLES, USE CAUTION WHEN UPDATING THESE VARIABLES

# variable AVAILABILITY_ZONE {
#     default = "a"
#     type = string
# }

# variable CIDR_BLOCK {
#     default = "10.0.0.0/16"
#     type = string
# }

# variable SUBNET_CIDR_BLOCK {
#     default = "10.0.0.0/28"
#     type = string
# }

# variable MINECRAFT_SERVER_PORT {
#     default = 25565
#     type = number
# }

# variable EBS_DEVICE_NAME {
#     default = "/dev/sdh"
#     type = string
# }

# variable EBS_SNAPSHOT_STORAGE_TIER {
#     default = "archive"
#     type = string
# }

# variable AMI_OWNER_NAME {
#     default = ["amazon"]
#     type = list(string)
# }

# variable INCLUDE_DEPRECATION_BOOLEAN {
#     default = false
#     type = bool
# }

# variable LAMBDA_PATH {
#     default = "monitoring_lambdas"
#     type = string
# }

# variable LAMBDA_NAME {
#     default = "vpc_monitoring.py"
#     type = string
# }

# variable ZIP {
#     default = "zip"
#     type = string
# }

# variable LAMBDA_FUNCTION_HANDLER_NAME {
#     default = "vpc_monitoring_handler"
#     type = string
# }

# variable LAMBDA_FUNCTION_NAME {
#     default = "mc_vpc_monitoring_lambda"
#     type = string
# }

# variable LAMBDA_RUNTIME_VERSION {
#     default = "python3.13"
#     type = string
# }

# variable LAMBDA_EXECUTE_PERMISSIONS {
#     default = ["logs:DescribeLogGroups", "logs:DescribeLogStreams", "logs:GetLogEvents", "ec2:CreateNetworkInterface",
#               "ec2:DescribeNetworkInterfaces", "ec2:DescribeInstances", "ec2:DescribeSecurityGroups", "ec2:DeleteNetworkInterface"]
#     type = list(string)
# }

# variable CLOUDWATCH_LOG_GROUP {
#     default = "mc_vpc_logs_group"
#     type = string
# }

# variable LOG_STREAM_NAME {
#     default = "mc_vpc_stream"
#     type = string
# }

# variable MONITORING_LAMBDA_RUN_FREQUENCY {
#     default = "rate(5 minutes)"
#     type = string
# }

# variable MONITORING_LAMBDA_RUN_FREQUENCY_RULE_NAME {
#     type = string
#     default = "vpc-active-connections-monitoring-lambda-rule"
# }

# variable EVENTBRIDGE_ACTION_TO_INVOKE_LAMBDA {
#     type = string
#     default = "lambda:InvokeFunction"
# }

# variable EVENTBRIDGE_PRINCIPAL_URL {
#     type = string
#     default = "events.amazonaws.com"
# }

# variable VPC_SECURITY_GROUP_CIDR_BLOCKS {
#     type = list(string)
#     default = ["0.0.0.0/0"]
# }

# variable SECURITY_GROUP_PROTOCOL {
#     type = string
#     default = "tcp"
# }

# variable VPC_MONITORING_LAMBDA_ROLE_NAME {
#     default = "mc_vpc_monitoring_lambda"
#     type = string
# }

# variable LAMBDA_LOGGING_PERMISSIONS {
#     default = ["logs:CreateLogGroup","logs:CreateLogStream","logs:PutLogEvents"]
#     type = list(string)
# }

# variable LOGS_ARN_WILDCARD {
#     default = "arn:aws:logs:*:*:*"
# }

# variable LOGS_GROUP_PATH {
#     default = "/aws/lambda/my_lambda_function"
# }