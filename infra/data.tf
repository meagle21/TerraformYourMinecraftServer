data "aws_ami" "MC_AMI" {
    owners = var.AMI_OWNER_NAME
    most_recent = var.MOST_RECENT_BOOLEAN
    include_deprecated = var.INCLUDE_DEPRECATION_BOOLEAN
    filter {
        name   = "name" 
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
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