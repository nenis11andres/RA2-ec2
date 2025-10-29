#!/bin/bash
set -eux

# Configurar logging
LOG=/var/log/nginx-userdata.log
exec > >(tee -a ${LOG}) 2>&1

# Actualizar el sistema e instalar dependencias
dnf update -y
dnf install -y docker git curl

# Iniciar y habilitar Docker
systemctl start docker
systemctl enable docker

# Instalar docker-compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Configurar permisos Docker y usuario
groupadd -f docker
usermod -aG docker ec2-user
systemctl restart docker
newgrp docker

# Esperar a que Docker esté listo
until docker info > /dev/null 2>&1; do
  echo "Esperando a que Docker esté disponible..."
  sleep 5
done

# Clonar repositorio
cd /home/ec2-user
rm -rf RA2-ec2
git clone https://github.com/nenis11andres/RA2-ec2.git
chown -R ec2-user:ec2-user RA2-ec2

# Construir y ejecutar contenedor
cd RA2-ec2/docker
sudo -u ec2-user /usr/local/bin/docker-compose build --no-cache nginx
sudo -u ec2-user /usr/local/bin/docker-compose up -d nginx

# Verificar estado
docker ps