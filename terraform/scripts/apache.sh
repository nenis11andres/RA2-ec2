#!/bin/bash
set -eux

LOG=/var/log/apache-userdata.log
exec > >(tee -a ${LOG}) 2>&1

# Actualizar e instalar dependencias
apt-get update -y
apt-get install -y git curl ca-certificates

# Instalar Docker usando script oficial
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sh /tmp/get-docker.sh

# Iniciar y habilitar Docker
systemctl enable --now docker

# Instalar docker-compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Añadir usuario admin al grupo docker
groupadd -f docker || true
usermod -aG docker admin || true

# Esperar a que Docker esté listo
until docker info > /dev/null 2>&1; do
  echo "Esperando a que Docker esté disponible..."
  sleep 1
done

# Clonar repo
cd /home/admin
if [ ! -d "RA2-ec2" ]; then
  git clone https://github.com/nenis11andres/RA2-ec2.git
fi
chown -R admin:admin RA2-ec2

# Corregir .env
sed -i 's/DATABASE_URL=.*/DATABASE_URL="mysql:\/\/root:@127.0.0.1:3306\/gymnasio?serverVersion=10.4.28-MariaDB\&charset=utf8mb4"/' /home/admin/RA2-ec2/gym/.env

# Construir y arrancar apache
cd /home/admin/RA2-ec2/docker
/usr/local/bin/docker-compose build --no-cache apache
/usr/local/bin/docker-compose up -d apache

# Mostrar estado
docker ps -a