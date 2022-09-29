data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }
    owners = ["099720109477"]
}

data "template_file" "main" {
    template = file("${path.module}/userdata.sh")
}
