data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name = "keyk"
  subnet_id = aws_subnet.strapi-subnet.id
  security_groups = [ aws_security_group.top_sec.id ]
  associate_public_ip_address = true
  

  user_data = <<-EOF
              #!/bin/bash
              exec > /var/log/user-data.log 2>&1

              sudo apt update -y
              sudo apt install -y docker.io git
              sudo usermod -aG docker ubuntu
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo chmod 777 /var/run/docker.sock                            

              git clone https://github.com/Zenisis/strap-docker.git

              if [ -d "strap-docker" ]; then
                cd strap-docker
                sudo docker build -t strap-project .
                sudo docker run -d -p 1337:1337 strap-project:latest
              else
                echo "Failed to clone the repository."
              fi
              EOF




  tags = {
    Name = "strapi-application"
  }
}

output "public_dns" {
  value = aws_instance.web.public_dns
  
}
