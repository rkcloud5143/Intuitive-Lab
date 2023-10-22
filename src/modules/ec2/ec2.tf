resource "aws_instance" "intuitive_ec2" {
  ami = data.aws_ami.ubuntu.id
  # uncomment if you don't need public IP associated with ec2
  associate_public_ip_address = true
  disable_api_termination     = true
  iam_instance_profile        = var.instance_profile
  key_name                    = var.key_name
  instance_type               = var.instance_type
  user_data                   = filebase64("${path.module}/script.sh")
  monitoring                  = true
  security_groups             = data.security_groups.public_sg.id
  subnet_id                   = data.subnet_id.public_subnet.id
  tags = {
    Name = "intuitive-dev-ec2-${count}"
  }
  volume_tags = {
    Name = "intuitive-dev-ec2-${count}"
  }
}

resource "aws_ebs_volume" "intuitive_ebs" {
  availability_zone = var.availability_zone
  size              = 40
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.intuitive_ebs.id
  instance_id = aws_instance.intuitive_ec2.id
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name                = "cpu-utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120" #seconds
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
    InstanceId = aws_instance.intuitive_ec2.id
  }

}