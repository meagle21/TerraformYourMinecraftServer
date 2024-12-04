output "server_ip_for_minecraft_console" {
  description = "This is what players need to put into the minecraft console to play"
  value       = "${aws_instance.mc_instance.public_ip}:${var.MINECRAFT_SERVER_PORT}"
}

output "selected_ami_id" {
  description = "The ID of the most recent Amazon Linux 2 AMI"
  value       = data.aws_ami.MC_AMI.id
}
