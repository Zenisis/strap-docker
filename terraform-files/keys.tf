
resource "aws_key_pair" "ke" {
  key_name   = "keyk"
  public_key = file("${path.module}/./id_rsa.pub")
}
 