# resource "aws_instance" "mc_instance" {
#   ami               = data.aws_ami.MC_AMI.id
#   availability_zone = var.default_region
#   instance_type     = var.instance_type
#   subnet_id = aws_subnet.mc_vpc_subnet.id
#   hibernation = true
# }

# resource "aws_cloudwatch_log_group" "mc_server_logs" {
#   name = "MC-server-log-group"
#   retention_in_days = 7
# }