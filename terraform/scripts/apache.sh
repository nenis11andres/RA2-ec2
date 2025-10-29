#!/bin/bash
# --------------------------------------------
# Script de inicialización para Debian/Ubuntu
# Instala Docker, Docker Compose, clona repo y levanta contenedor Apache
# --------------------------------------------

set -e  # Salir si hay error

# Actualizar sistema e instalar dependencias
apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release git

# Instalar Docker siguiendo la guía oficial
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

# Instalar Docker Compose manualmente (por si el paquete docker-compose-plugin falla)
mkdir -p /usr/libexec/docker/cli-plugins/
curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m)" \
     -o /usr/libexec/docker/cli-plugins/docker-compose
chmod +x /usr/libexec/docker/cli-plugins/docker-compose

# Verificar instalación
docker compose version

# Habilitar y arrancar Docker
systemctl enable docker
systemctl start docker

# Agregar usuario admin al grupo docker
usermod -aG docker admin

# Esperar a que Docker esté activo
until docker info >/dev/null 2>&1; do
    echo "Esperando a que Docker esté listo..."
    sleep 2
done

# Clonar el repositorio si no existe
cd /home/admin || cd /root
if [ ! -d "RA2-ec2" ]; then
    git clone https://github.com/nenis11andres/RA2-ec2.git
fi
cd RA2-ec2/docker

# Levantar contenedor Apache usando Docker Compose
docker compose up -d apache || {
    echo "Error levantando contenedor, mostrando logs..."
    docker compose logs
    exit 1
}

# Dar permisos al usuario admin
chown -R admin:admin /home/admin/RA2-ec2

echo "¡Apache levantado correctamente!"
docker compose ps
