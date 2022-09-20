resource "aws_instance" "jenkins-instance" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.small"
  disable_api_termination = true
  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.jenkins-securitygroup.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  ## Either use user_data or use "remote-exec" at one time
  ## For autoscaling and clean deployment only use user_data
  ## upload scripts/nginx folder on s3 and download it from there in user_data
  ## Or optionally run manual script for remote-exec after terroform completes deployment
  # user data
  user_data = data.cloudinit_config.cloudinit-jenkins.rendered

  # File Provisioner (Ansible / Puppet Provisioner)
/**
  provisioner "file" {
    source      = "scripts/nginx"
    destination = "/tmp"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx/reverseproxy-setup.sh",
      "sudo sed -i -e 's/\r$//' /tmp/nginx/reverseproxy-setup.sh",  # Remove the spurious CR characters.
      "sudo /tmp/nginx/reverseproxy-setup.sh",
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
**/

}

resource "aws_ebs_volume" "jenkins-data" {
  availability_zone = "us-west-1b"
  size              = 100
  type              = "gp2"
  tags = {
    Name = "jenkins-data"
  }

}

resource "aws_volume_attachment" "jenkins-data-attachment" {
  device_name = var.INSTANCE_DEVICE_NAME
  volume_id   = aws_ebs_volume.jenkins-data.id
  instance_id = aws_instance.jenkins-instance.id
  skip_destroy = true

}

