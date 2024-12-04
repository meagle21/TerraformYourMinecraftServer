// EBS Volume
resource "aws_ebs_volume" "mc_ebs_volume" {
  availability_zone = var.default_az
  size              = var.storage_volume_size
}

// EBS Volume attachment
resource "aws_volume_attachment" "mc_ebs_volume_attach" {
  device_name = var.EBS_DEVICE_NAME
  volume_id   = aws_ebs_volume.mc_ebs_volume.id
  instance_id = aws_instance.mc_instance.id
}

// EBS Volume back up
resource "aws_ebs_snapshot" "mc_ebs_volume_snapshot" {
  volume_id = aws_ebs_volume.mc_ebs_volume.id
  storage_tier = var.EBS_SNAPSHOT_STORAGE_TIER
}