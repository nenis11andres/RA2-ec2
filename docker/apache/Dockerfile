# Base Debian
FROM debian:bookworm

# Instalar Apache + PHP + utilidades
RUN apt-get update && \
    apt-get install -y apache2 php php-cli libapache2-mod-php php-mbstring php-xml php-pdo php-mysql unzip curl git procps && \
    apt-get clean

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

# Copiar proyecto al contenedor
COPY gym/ ./

# Instalar dependencias PHP
RUN composer install --no-interaction --optimize-autoloader

# Permisos
RUN chown -R www-data:www-data /var/www/html || true
RUN chmod -R 755 /var/www/html || true

# Copiar configuración de Apache si existe en repo
COPY docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]