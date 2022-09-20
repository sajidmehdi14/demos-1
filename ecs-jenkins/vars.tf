variable "AWS_REGION" {
  default = "us-west-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}

# Full List: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
## Amazon Linix 2 AMIs for ECS nodes

variable "ECS_AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-03f8a7b55051ae0d4"
    us-east-2 = "ami-0693a7971cd761811"
    us-west-2 = "ami-014b01f8aa1a38b78"
    us-west-1 = "ami-0f987281f7836b330"
  }
}


## Ubuntu 22.04 LTS AMIs

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-052efd3df9dad4825"
    us-east-2 = "ami-02f3416038bdb17fb"
    us-west-2 = "ami-0d70546e43a941d70"
    us-west-1 = "ami-085284d24fe829cd0"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "JENKINS_VERSION" {
  default = "2.361.1"
}

