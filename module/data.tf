data "aws_ami" "MC_AMI" {
    owners = ["amazon"]
    most_recent = true
    include_deprecated = false
    filter {
        name   = "name" 
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    filter {
        name   = "block-device-mapping.volume-size" 
        values = [var.storage_volume_size]
    }
}

locals {
    VPC_MONITORING_ARCHIVE = replace(var.LAMBDA_NAME, "py", "zip")
}

data "archive_file" "lambda_zip" {
  type        = var.ZIP
  source_dir  = "../${var.LAMBDA_PATH}"  # Path to the folder with your Python code
  output_path = "${path.module}/${local.VPC_MONITORING_ARCHIVE}"  # Path to save the generated ZIP
}