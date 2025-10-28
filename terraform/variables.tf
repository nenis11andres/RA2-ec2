# Región AWS
variable "aws_region" {
  description = "Región AWS donde se crearán los recursos"
  type        = string
  default     = "us-east-1"
}

# AMIs para cada instancia
variable "nginx_ami" {
  description = "AMI ID para Amazon Linux 2"
  type        = string
  default     = "ami-0440d3b780d96b29d" # Amazon Linux 2023 en us-east-1
}

variable "apache_ami" {
  description = "AMI ID para Debian"
  type        = string
  default     = "ami-058bd2d568351da34" # Debian 12 en us-east-1
}

# Tipo de instancia
variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

# Nombre de la clave SSH para nginx
variable "key_name" {
  description = "Nombre del key pair para SSH"
  type        = string
  default     = "nginx" # Reemplazar con tu key pair
}

# Nombre de la clave SSH para apache
variable "key_name2" {
  description = "Nombre del key pair para SSH"
  type        = string
  default     = "apache" # Reemplazar con tu key pair
}