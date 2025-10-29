#!/bin/bash
set -eux

# Configurar logging
LOG=/var/log/apache-userdata.log
exec > >(tee -a ${LOG}) 2>&1

echo "Inicio apache user-data"

# Actualizar e instalar utilidades
apt-get update -y || true
apt-get install -y git curl wget ca-certificates gnupg lsb-release || true

# Instalar Docker (script oficial)
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sh /tmp/get-docker.sh

# Iniciar y habilitar Docker
systemctl enable --now docker

# Instalar docker-compose (binario)
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Añadir usuario admin al grupo docker
groupadd -f docker || true
usermod -aG docker admin || true

# Esperar a que Docker esté listo
until docker info > /dev/null 2>&1; do
  echo "Esperando a Docker..."
  sleep 2
done

# Clonar repo (usuario admin)
cd /home/admin
rm -rf RA2-ec2
git clone https://github.com/nenis11andres/RA2-ec2.git
chown -R admin:admin RA2-ec2

# Construir imagen y levantar contenedor apache usando docker-compose
cd /home/admin/RA2-ec2/docker
/usr/local/bin/docker-compose build --no-cache apache
/usr/local/bin/docker-compose up -d --remove-orphans apache

# Verificación final
sleep 3
docker ps -a
echo "Fin apache user-data"