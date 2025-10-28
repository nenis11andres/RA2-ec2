#!/bin/bash
set -eux

# Actualizar e instalar Docker y dependencias
apt-get update -y
apt-get install -y docker.io docker-compose git
systemctl start docker
systemctl enable docker

# Usuario admin puede usar Docker
usermod -aG docker admin

# Clonar repositorio
cd /home/admin
git clone https://github.com/nenis11andres/RA2-ec2.git

# Cambiar permisos de la carpeta gym para Apache
chown -R admin:admin RA2-ec2/gym

# Levantar contenedor Apache
cd RA2-ec2/docker
docker-compose up -d apache
