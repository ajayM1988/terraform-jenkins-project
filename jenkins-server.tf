resource "aws_instance" "jenkins" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name = var.key_name

  subnet_id = aws_subnet.public_subnet_1.id

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name

  associate_public_ip_address = true

  user_data = file("jenkins.sh")

  tags = {
    Name = "${var.environment}-jenkins-server"
  }
}
###################