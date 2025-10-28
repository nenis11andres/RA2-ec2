#!/bin/bash
set -eux

# Actualizar e instalar docker
apt-get update -y
apt-get install -y docker.io docker-compose git
systemctl start docker
systemctl enable docker

# Asegurar que el usuario admin puede usar docker
usermod -aG docker admin

# Clonar repositorio
cd /home/admin
git clone https://github.com/nenis11andres/RA2-ec2.git

# Arrancar contenedor
cd RA2-ec2/docker
docker-compose up -d apache