#!/bin/bash
set -eux

# Actualizar e instalar Docker y dependencias
yum update -y
yum install -y docker git
systemctl start docker
systemctl enable docker

# Instalar Docker Compose
curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Usuario ec2-user puede usar Docker
usermod -aG docker ec2-user

# Clonar repositorio
cd /home/ec2-user
git clone https://github.com/nenis11andres/RA2-ec2.git

# Cambiar permisos de la carpeta gym para PHP-FPM
chown -R ec2-user:ec2-user RA2-ec2/gym

# Levantar contenedor Nginx
cd RA2-ec2/docker
docker-compose up -d nginx
