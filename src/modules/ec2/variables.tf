variable "key_name" {
  type    = string
  default = "intuitive-ec2-key"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_profile" {
  type    = string
  default = "intuitive-ec2-role"
}
variable "security_groups" {
  type = list()
}
variable "subnet_id" {
  type = list()
}
variable "availability_zone" {
  type    = string
  default = "us-east-1a"

}