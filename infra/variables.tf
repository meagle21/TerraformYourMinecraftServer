// INPUT BASED VARIABLES
variable default_region {
    default = "us-east-2"
    type = string
}

variable storage_volume_size {
    default = 4
    type = number
}

variable instance_type {
    default = "t2.micro"
    type = string
}











// HARD CODED VARIABLES, USE CAUTION WHEN UPDATING THESE VARIABLES
variable CIDR_BLOCK {
    default = "10.0.0.0/16"
    type = string
}

variable MINECRAFT_SERVER_PORT {
    default = 25565
    type = number
}

variable EBS_DEVICE_NAME {
    default = "/dev/sdh"
    type = string
}

variable EBS_SNAPSHOT_STORAGE_TIER {
    default = "archive"
    type = string
}

variable AMI_OWNER_NAME {
    default = ["amazon"]
    type = list(string)
}

variable MOST_RECENT_BOOLEAN {
    default = true
    type = bool
}

variable INCLUDE_DEPRECATION_BOOLEAN {
    default = false
    type = bool
}

variable LAMBDA_PATH {
    default = "monitoring_lambda"
    type = string
}

variable LAMBDA_NAME {
    default = "server_monitoring.py"
    type = string
}

variable ZIP {
    default = "zip"
    type = string
}

variable LAMBDA_FUNCTION_HANDLER_NAME {
    default = "server_monitoring"
    type = string
}

variable LAMBDA_FUNCTION_NAME {
    default = "mc_server_monitoring_lambda"
    type = string
}

variable LAMBDA_RUNTIME_VERSION {
    default = "python3.13"
    type = string
}

variable LAMBDA_PERMISSIONS {
    default = ["ec2:DescribeInstances", "ec2:DescribeInstanceStatus",
               "ec2:DescribeRegions", "ec2:StopInstances", "ec2:TerminateInstances"
              ]
    type = list(string)
}





