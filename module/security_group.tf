# resource "aws_security_group" "mc_vpc_security_group" {
#     vpc_id      = aws_vpc.mc_vpc.id
#     ingress {
#         from_port   = var.MINECRAFT_SERVER_PORT
#         to_port     = var.MINECRAFT_SERVER_PORT
#         protocol    = var.SECURITY_GROUP_PROTOCOL
#         cidr_blocks = var.VPC_SECURITY_GROUP_CIDR_BLOCKS
#     }

#     egress {
#         from_port        = var.MINECRAFT_SERVER_PORT
#         to_port          = var.MINECRAFT_SERVER_PORT
#         protocol         = var.SECURITY_GROUP_PROTOCOL
#         cidr_blocks      = var.VPC_SECURITY_GROUP_CIDR_BLOCKS
#     }
# }