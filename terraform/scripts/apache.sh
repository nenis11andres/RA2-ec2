#!/bin/bash
set -eux

# Configurar logging
LOG=/var/log/apache-userdata.log
exec > >(tee -a ${LOG}) 2>&1

# Actualizar e instalar Docker
apt-get update -y
apt-get install -y docker.io docker-compose git
systemctl start docker
systemctl enable docker

# Configurar permisos Docker
usermod -aG docker admin
systemctl restart docker

# Esperar a que Docker esté listo
until docker info > /dev/null 2>&1; do
  echo "Esperando a que Docker esté disponible..."
  sleep 5
done

# Clonar repositorio
cd /home/admin
rm -rf RA2-ec2
git clone https://github.com/nenis11andres/RA2-ec2.git
chown -R admin:admin RA2-ec2

# Construir y ejecutar contenedor
cd RA2-ec2/docker
docker-compose build --no-cache apache
docker-compose up -d apache

# Verificar estado
docker ps