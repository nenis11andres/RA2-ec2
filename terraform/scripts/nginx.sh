#!/bin/bash
set -eux

# Actualizar e instalar docker
yum update -y
yum install -y docker git
systemctl start docker
systemctl enable docker

# Instalar docker compose
curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Asegurar que el usuario ec2-user puede usar docker
usermod -aG docker ec2-user

# Clonar repositorio
cd /home/ec2-user
git clone https://github.com/nenis11andres/RA2-ec2.git

# Arrancar contenedor
cd RA2-ec2/docker
docker-compose up -d nginx