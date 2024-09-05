data "aws_ami" "this" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values = ["amzn-ami-hvm-*-x86_64-gp2"]
    }
}
