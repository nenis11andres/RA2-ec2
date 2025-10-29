#!/bin/bash
# --------------------------------------------
# Script de inicialización para Amazon Linux 2023
# Instala Docker, Docker Compose + Buildx, clona repo y levanta contenedor Nginx
# --------------------------------------------

# Actualizar sistema e instalar dependencias
dnf update -y
dnf install -y docker git curl

# Habilitar y arrancar Docker
systemctl enable docker
systemctl start docker

# Agregar usuario ec2-user al grupo docker
usermod -aG docker ec2-user

# Esperar a que Docker esté activo
until docker info >/dev/null 2>&1; do
    echo "Esperando a que Docker esté listo..."
    sleep 2
done

# Instalar Docker Compose (plugin)
mkdir -p /usr/libexec/docker/cli-plugins/
curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m)" \
     -o /usr/libexec/docker/cli-plugins/docker-compose
chmod +x /usr/libexec/docker/cli-plugins/docker-compose

# Instalar Docker Buildx (para builds avanzados)
curl -SL "https://github.com/docker/buildx/releases/latest/download/buildx-v0.29.1.linux-$(uname -m)" \
     -o /usr/libexec/docker/cli-plugins/docker-buildx
chmod +x /usr/libexec/docker/cli-plugins/docker-buildx

# Verificar instalaciones
docker --version
docker compose version
docker buildx version

# Clonar el repositorio si no existe
cd /home/ec2-user
if [ ! -d "RA2-ec2" ]; then
    git clone https://github.com/nenis11andres/RA2-ec2.git
fi
cd RA2-ec2/docker

# Opcional: eliminar línea 'version:' obsoleta del docker-compose.yaml
sed -i '/^version:/d' docker-compose.yaml

# Levantar contenedor Nginx usando Docker Compose
docker compose up -d nginx

# Dar permisos al usuario ec2-user
chown -R ec2-user:ec2-user /home/ec2-user/RA2-ec2
