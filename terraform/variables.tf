variable "location" {
  default = "us-east-1"
}

variable "ami-id" {
  default = "ami-0c7217cdde317cfec"
}

variable "instance-type" {
  default = "t2.medium"
}

variable "key" {
  default = "volvo-key"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
}


variable "subnet-cidr" {
  default = "10.0.1.0/24"

}

variable "subent-az" {
  default = "us-east-1a"
}