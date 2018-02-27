#################################################################
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Licensed Materials - Property of IBM
#
# ©Copyright IBM Corp. 2017, 2018.
#
#################################################################

provider "aws" {
  version = "~> 1.2"
  region  = "us-east-1"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "vpc_name_tag" {
  description = "Name of the Virtual Private Cloud (VPC) this resource is going to be deployed into"
  default = "icpVPC"
}

variable "subnet_cidr" {
  description = "Subnet cidr"
  default = "172.31.0.0/20"
}

data "aws_vpc" "selected" {
  state = "available"

  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name_tag}"]
  }
}

data "aws_subnet" "selected" {
  state      = "available"
  vpc_id     = "${data.aws_vpc.selected.id}"
  cidr_block = "${var.subnet_cidr}"
}

variable "public_ssh_key_name" {
  description = "Name of the public SSH key used to connect to the virtual guest"
  default = "jowkey"
}

variable "public_ssh_key" {
  description = "Public SSH key used to connect to the virtual guest"
  default = "sh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcBLUeO7Nlj8+R0gbDRUmxwbXbUwiGLSUn46y0ad5MCXrwSfXUWFHa6AU8bvCu2FNM5XHV/Zopv+of3J+vtcdrikyFw7JAJ+92LDGzc6lg7nTCp6YF0mhdviVsf/cZhHf+YWAIbPdhEto7/TJuRoK1iUcqM7WyfQtnshGhawLk6kJ6Ymtil90XZDtKp1C61lVdlD6lIx0qHfb+ivyMJeBRPtPWJ9h8AQEri8LpbgXriGJuTY0CBugS/1CD4yi3Oo/2F7WWAC6v5auVf2gBQq4s5rDEomnKCgU8UxyguwdPXkVRJLaOWHw1eQD6tD9MQWaYmhTOmNlvePO/P/ilfBEf root@ycfcmaster"
}

#Variable : AWS image name
variable "aws_image" {
  type = "string"
  description = "Operating system image id / template that should be used when creating the virtual image"
  default = "ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"
}

variable "aws_ami_owner_id" {
  description = "AWS AMI Owner ID"
  default = "099720109477"
}

# Lookup for AMI based on image name and owner ID
data "aws_ami" "aws_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["${var.aws_image}*"]
  }
  owners = ["${var.aws_ami_owner_id}"]
}

resource "aws_key_pair" "orpheus_public_key" {
  key_name   = "${var.public_ssh_key_name}"
  public_key = "${var.public_ssh_key}"
}

resource "aws_instance" "orpheus_ubuntu_micro" {
  instance_type = "t2.micro"
  ami           = "${data.aws_ami.aws_ami.id}"
  subnet_id     = "${data.aws_subnet.selected.id}"
  key_name      = "${aws_key_pair.orpheus_public_key.id}"
}
