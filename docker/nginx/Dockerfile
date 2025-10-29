# Base Amazon Linux 2
FROM amazonlinux:2

# Instalar nginx, PHP y utilidades
RUN yum update -y && \
    amazon-linux-extras enable nginx1 php8.2 && \
    yum install -y nginx php-cli php-fpm php-mbstring php-xml php-pdo php-mysqlnd unzip curl git procps && \
    yum clean all

# Configurar PHP-FPM (usar TCP y usuario nginx)
RUN sed -i 's|listen = /run/php-fpm/www.sock|listen = 127.0.0.1:9000|g' /etc/php-fpm.d/www.conf && \
    sed -i 's|user = apache|user = nginx|g' /etc/php-fpm.d/www.conf && \
    sed -i 's|group = apache|group = nginx|g' /etc/php-fpm.d/www.conf

# Asegurar directorio de sesiones PHP
RUN mkdir -p /var/lib/php/session && \
    chown -R nginx:nginx /var/lib/php/session && \
    chmod 1733 /var/lib/php/session

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

# Copiar proyecto al contenedor
COPY gym/ ./

# Instalar dependencias PHP (si falla, muestra error para debug)
RUN composer install --no-interaction --optimize-autoloader

# Permisos
RUN chown -R nginx:nginx /var/www/html || true
RUN chmod -R 755 /var/www/html || true

# Copiar configuración nginx si la tienes en repo (si no, usa la configuración por defecto)
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]