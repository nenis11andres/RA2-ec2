#!/bin/bash
set -eux

LOG=/var/log/nginx-userdata.log
exec > >(tee -a ${LOG}) 2>&1

# Actualizar e instalar dependencias
yum update -y
yum install -y git curl

# Instalar Docker usando script oficial
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sh /tmp/get-docker.sh

# Iniciar y habilitar Docker
systemctl enable --now docker

# Instalar docker-compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Añadir usuario al grupo docker
groupadd -f docker || true
usermod -aG docker ec2-user || true

# Esperar a que Docker esté listo
until docker info > /dev/null 2>&1; do
  echo "Esperando a que Docker esté disponible..."
  sleep 1
done

# Clonar repo
cd /home/ec2-user
if [ ! -d "RA2-ec2" ]; then
  git clone https://github.com/nenis11andres/RA2-ec2.git
fi
chown -R ec2-user:ec2-user RA2-ec2

# Corregir .env
sed -i 's/DATABASE_URL=.*/DATABASE_URL="mysql:\/\/root:@127.0.0.1:3306\/gymnasio?serverVersion=10.4.28-MariaDB\&charset=utf8mb4"/' /home/ec2-user/RA2-ec2/gym/.env

# Construir y arrancar nginx
cd /home/ec2-user/RA2-ec2/docker
/usr/local/bin/docker-compose build --no-cache nginx
/usr/local/bin/docker-compose up -d nginx

# Mostrar estado
docker ps -a