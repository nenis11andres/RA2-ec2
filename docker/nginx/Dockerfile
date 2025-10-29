# Base Amazon Linux 2
FROM amazonlinux:2

# Actualizar e instalar nginx + PHP 8.2 + extensiones
RUN yum update -y && \
    amazon-linux-extras enable nginx1 php8.2 && \
    yum install -y nginx php-cli php-fpm php-mbstring php-xml php-pdo php-mysqlnd unzip curl git && \
    yum clean all

# Configurar PHP-FPM
RUN sed -i 's/listen = \/run\/php-fpm\/www.sock/listen = 127.0.0.1:9000/g' /etc/php-fpm.d/www.conf && \
    sed -i 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf && \
    sed -i 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Directorio de trabajo
WORKDIR /var/www/html

# Copiar proyecto Symfony
COPY gym/ .

# Instalar dependencias
RUN composer install --no-interaction --optimize-autoloader

# Dar permisos
RUN chown -R nginx:nginx /var/www/html && \
    chmod -R 755 /var/www/html

# Copiar configuración de Nginx
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["sh", "-c", "php-fpm && nginx -g 'daemon off;'"]