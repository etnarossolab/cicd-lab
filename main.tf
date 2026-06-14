# Deliberately misconfigured for the lab — do NOT use in production

resource "aws_s3_bucket" "data" {
  bucket = "cicd-lab-demo-bucket"
}

# Misconfig 1: bucket ACL set to public-read
resource "aws_s3_bucket_acl" "data_acl" {
  bucket = aws_s3_bucket.data.id
  acl    = "public-read"
}

# Misconfig 2: security group open to the world on SSH
resource "aws_security_group" "open_ssh" {
  name = "open-ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Misconfig 3: unencrypted EBS volume
resource "aws_ebs_volume" "data_vol" {
  availability_zone = "ap-northeast-1a"
  size              = 10
  encrypted         = false
}
