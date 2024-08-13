data "aws_vpc" "default" {
 default = true
}

resource "aws_security_group" "TerraJenker-SG" {
 name        = "TerraJenker-SG"
 description = "Allow HTTPS to web server"
 vpc_id      = data.aws_vpc.default.id

ingress {
   description = "HTTPS ingress"
   from_port   = 443
   to_port     = 443
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

ingress {
   description = "Custom TCP"
   from_port   = 3000
   to_port     = 3000
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

ingress {
   description = "SSH"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 

ingress {
   description = "Custom TCP"
   from_port   = 8080
   to_port     = 8080
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
   description = "HTTP"
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }


egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}



resource "aws_instance" "TerraJenker-EC21" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.TerraJenker-SG.id]

    # User data script to install Ansible
  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y git
              git clone https://github.com/Janemils/TerraJenker.git /home/ubuntu/TerraJenker
              chmod +x /home/ubuntu/TerraJenker/Jenkins-Docker.sh
              /home/ubuntu/TerraJenker/Jenkins-Docker.sh
              # Wait for Jenkins to be up and running
              sleep 300  # Adjust this as needed

              # Check if Jenkins is installed and running
              if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
              sudo cat /var/lib/jenkins/secrets/initialAdminPassword > Jenkins_Admin.txt
              sudo cat /var/lib/jenkins/secrets/initialAdminPassword
              else
              echo "Jenkins admin password file not found."
              fi
              EOF

  tags = {
    Name = "TerraJenker-EC21"
  }
}

output "file_content" {
  value = file("Jenkins_Admin.txt")
}