resource "aws_instance" "netbox-instance" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.small"
  key_name                = var.key_pair_name
  vpc_security_group_ids  = ["aws_security_group.netbox-instance.id"] 

  tags = {
    Name = "netbox-instance"
  }

  lifecycle {
    ignore_changes  = [ami]
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "false"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -",
      "sudo apt-get install -y unzip nginx nginx-full",
      "curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -",
      "echo \"deb https://dl.yarnpkg.com/debian/ stable main\" | sudo tee /etc/apt/sources.list.d/yarn.list",
      "sudo apt-get update && sudo apt-get install yarn",
    ]

    connection  {
      host          = self.public_ip
      type          = "ssh"
      user          = "ubuntu"
      private_key   = file(var.key_pair_location)

    }

    on_failure = fail
  }
}