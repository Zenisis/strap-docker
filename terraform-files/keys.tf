
resource "aws_key_pair" "keys1" {
  key_name   = "keyk"
  public_key = file("${path.module}/./id_rsa.pub")
}
 
