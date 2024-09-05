data "aws_ami" "this" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values = ["amz2-ami-hvm-*-arm64-gp2"]
    }
}
