# Base Amazon Linux 2
FROM amazonlinux:2

# Actualizar e instalar nginx + PHP 8.2 + extensiones
RUN yum update -y && \
    amazon-linux-extras enable nginx1 php8.2 && \
    yum install -y nginx php-cli php-fpm php-mbstring php-xml php-pdo php-mysqlnd unzip curl git && \
    yum clean all

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Directorio de trabajo
WORKDIR /var/www/html

# Copiar proyecto Symfony (ajustar ruta porque docker-compose build usa context: ..)
COPY ../gym /var/www/html

# Copiar configuración de Nginx (ruta relativa al Dockerfile, pero con contexto ..)
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto HTTP
EXPOSE 80

# Iniciar servicios
CMD php-fpm -D && nginx -g 'daemon off;'
